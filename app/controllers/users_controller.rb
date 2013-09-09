class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:index, :edit, :update, :following, :followers, :follow, :unfollow, :team, :defier, :invite_group]
  before_filter :correct_user,   only: [:edit, :update, :notifications]
  before_filter :admin_user,     only: :destroy
  before_filter :load_group, only: :invite_group
  
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def update
    @user = User.find(params[:id])
      if @user.update_attributes(params[:user])
        flash[:success] = "Profile updated"
             sign_in @user, :bypass => true
             redirect_to @user
      else
        render 'edit'
      end
  end
  
  def notifications
    @user = User.find(params[:id])
  end
  
  def active
    @user = User.find(params[:id])
  end
  
  def my_groups
    @user = User.find(params[:id])
  end
  
  def activities
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    @activities = PublicActivity::Activity.order("created_at desc").where(owner_id: @user.id)
  end
  
  def show
      @user = User.find(params[:id])
      if current_user && current_user == @user
        redirect_to notifications_user_path(@user)
      else
        redirect_to activities_user_path(@user)
      end
  end
  
  
  def following
      @title = "Following"
      @user = User.find(params[:id])
      @users = @user.followed_users.paginate(page: params[:page])
      render 'show_follow'
  end

  def followers
      @title = "Followers"
      @user = User.find(params[:id])
      @users = @user.followers.paginate(page: params[:page])
      render 'show_follow'
  end
  
  def follow
    @user = User.find(params[:id])
    if current_user
      if current_user == @user
        redirect_to :back
        flash[:error] = "You cannot follow yourself."
      else
        current_user.follow(@user)
        redirect_to :back
        @user.create_activity :following, owner: current_user
        flash[:notice] = "You are now following #{@user.name}."
      end
    else
      flash[:error] = "You must <a href='/users/sign_in'>login</a> to follow #{@user.name}.".html_safe
    end
  end
  
  def unfollow
    @user = User.find(params[:id])

    if current_user
      current_user.stop_following(@user)
      redirect_to :back
      flash[:notice] = "You are no longer following #{@user.name}."
    else
      flash[:error] = "You must <a href='/users/sign_in'>login</a> to unfollow #{@user.name}.".html_safe
    end
  end
  
  def team
    @user = User.find(params[:id])
    if current_user
      if current_user == @user
        redirect_to :back
        flash[:error] = "You cannot make team with yourself"
      else
        current_user.team!(@user)
        flash[:notice] = "#{@user.name} doit accepter d'etre votre coequipier"
        redirect_to :back
      end
    else
      flash[:error] = "You must <a href='/users/sign_in'>login</a> to make teams #{@user.name}.".html_safe
    end       
  end
  
  def defier
    @user = User.find(params[:id])
    if current_user
      if current_user == @user
        redirect_to :back
        flash[:error] = "You cannot make team with yourself"
      else
        current_user.defier!(@user)
        redirect_to new_challenge_path
        flash[:notice] = "#{@user.name} doit accepter d'etre votre coequipier"
      end
    else
      flash[:error] = "You must <a href='/users/sign_in'>login</a> to make teams #{@user.name}.".html_safe
    end
  end
  
  def invite_group
    @user = User.find(params[:id])
    @group.invite!(@user)
    redirect_to :back
  end
  
  private
  
  def correct_user
        @user = User.find(params[:id])
        redirect_to(root_path) unless current_user == @user
  end
  
  def admin_user
        redirect_to(root_path) unless current_user.admin?
  end
  
  def load_group
    resource, id= request.path.split('/')[1, 2]
    @group = resource.singularize.classify.constantize.find(id)
  end
end
