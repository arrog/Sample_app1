class GroupsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :admin_user,   only: [:rajouter]
  
  def new
    @group = Group.new
  end
  
  def create
      @group = Group.new(params[:group])
      if @group.save
        @membership = current_user.memberships.create(group_id: @group.id, role:"admin", state:"accepted")
        flash[:success] = "You created a new group!"
        redirect_to @group
      else
        render 'new'
      end      
  end
    
  def show
      @group = Group.find(params[:id])
  end
  
  def index
    @groups = Group.all
  end
  
  def rejoindre
    @group = Group.find(params[:id])
    if current_user
        current_user.rejoindre!(@group)
        redirect_to :back
        flash[:notice] = "Les Responsables du groupe doivent maintenant accepter votre demande"
    else
      flash[:error] = "You must <a href='/users/sign_in'>login</a> to join a group #{@user.name}.".html_safe
    end
  end
  
  def rajouter
    @group = Group.find(params[:id])
  end
  
  
  private

   def admin_user
     @group = Group.find(params[:id])
     redirect_to(root_path) unless current_user.admin?(@group)
   end


end