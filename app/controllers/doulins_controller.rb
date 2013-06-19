class DoulinsController < ApplicationController
  before_filter :authenticate_user!, only: [:vote_expert]
  before_filter :allowed, only: :show
  before_filter :verify_is_admin,  except: [:show, :vote_expert, :start, :next, :finish, :follow, :unfollow]
  
  has_scope :permission_doulin
  
  def new
    @doulin = Doulin.new
  end
  
  def create
      @doulin = Doulin.new(params[:doulin])
      if @doulin.save
        flash[:success] = "You created a new debate!"
        redirect_to @doulin
      else
        render 'new'
      end      
  end
    
  def show
      @doulin = Doulin.find(params[:id])
      @argumentable = @doulin
      @commentable = @doulin
      @expertise = @doulin.expertises.new
      @arguments = @argumentable.arguments
      @argument = Argument.new
      @comments = @commentable.comments
      @comment = @commentable.comments.new
  end
  
  def edit 
  end
  
  def index
    if current_user.try(:admin?)
      if params[:cat] && !params[:cat].empty?
        @current_category = Cat.find(params[:cat])
        @doulins = Doulin.where(:cat_id => @current_category.id)
      else
        @doulins = Doulin.all
      end
    end
  end
  
  #def update
   #   if @user.update_attributes(params[:user])
    #    flash[:success] = "Profile updated"
     #         sign_in @user
      #        redirect_to @user
      #else
       # render 'edit'
      #end
  #end
  
  def destroy
      Doulin.find(params[:id]).destroy
      flash[:success] = "Debate deleted."
      redirect_to debates_url
  end
  
  
  def vote_expert
     value = params[:type] == "up" ? 1 : -1
     @doulin = Doulin.find(params[:id])
     @doulin.add_or_update_evaluation(:vote_experts, value, current_user)
     @doulin.create_activity :vote, owner: current_user
     redirect_to :back, notice: "Thank you for voting"
   end
  
  
   def ready
     @doulin = Doulin.find(params[:id])
     @doulin.ready
     redirect_to doulin_path(@doulin)
   end
   
   def publish
      @doulin = Doulin.find(params[:id])
      @doulin.publish
      redirect_to doulin_path(@doulin)
   end
   
   def start
       @doulin = Doulin.find(params[:id])
       @doulin.start
       redirect_to :back
    end
    
    def next
        @doulin = Doulin.find(params[:id])
        @doulin.next
        redirect_to :back
     end
    
   def finish
      @doulin = Doulin.find(params[:id])
      @doulin.finish
      redirect_to :back
   end
   
   def follow
     @doulin = Doulin.find(params[:id])
     if current_user
       current_user.follow(@doulin)
       @doulin.create_activity :follow, owner: current_user
       redirect_to :back
       flash[:notice] = "You are now following #{@doulin.title}."
     else
       flash[:error] = "You must <a href='/users/sign_in'>login</a> to follow #{@doulin.title}.".html_safe
     end
   end

   def unfollow
     @challenge = Challenge.find(params[:id])
     if current_user
       current_user.stop_following(@doulin)
       redirect_to :back
       flash[:notice] = "You are no longer following #{@doulin.title}."
     else
       flash[:error] = "You must <a href='/users/sign_in'>login</a> to unfollow #{@doulin.title}.".html_safe
     end
   end
   
  
  private
  
  def allowed
    @doulin = Doulin.find(params[:id])
    if ["offline", "complete_off"].include?(@doulin.state)
      redirect_to(root_path) unless current_user.try(:admin?)
    end
  end
  
  def verify_is_admin
     (current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.try(:admin?))
   end
end