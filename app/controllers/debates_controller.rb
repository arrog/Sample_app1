class DebatesController < ApplicationController
  before_filter :allowed, only: :show
  before_filter :verify_is_admin,  only: [:new, :edit, :create, :destroy, :update, :index]
  before_filter :authenticate_user!, only: [:vote]

  has_scope :permission_debate
    
  def new
    @debate = Debate.new
  end
  
  def create
      @debate = Debate.new(params[:debate])
      if @debate.save
        flash[:success] = "You created a new debate!"
        redirect_to @debate
      else
        render 'new'
      end      
  end
    
  def show
      @debate = Debate.find(params[:id])
      @argumentable = @debate
      @arguments = @argumentable.arguments
      @argument = Argument.new
      @argcom = Argcom.new
     
  end
  
  def edit 
    @debate = Debate.find(params[:id])
  end
  
  def index
    if current_user.try(:admin?)
      if params[:cat] && !params[:cat].empty?
        @current_category = Cat.find(params[:cat])
        @debates = Debate.where(:cat_id => @current_category.id)
      else
        @debates = Debate.all
      end
    end
  end
  
  
  def update
    @debate = Debate.find(params[:id])
       if @debate.update_attributes(params[:debate])
         flash[:success] = "Profile updated"
              redirect_to @debate
       else
         render 'edit'
       end
  end

  
  def destroy
      Debate.find(params[:id]).destroy
      flash[:success] = "Debate deleted."
      redirect_to debates_url
  end
  
  
  def vote
     value = params[:type] == "up" ? 1 :
        value = params[:type] == "down" ? -1 : 0
     @debate = Debate.find(params[:id])
     @debate.add_or_update_evaluation(:votes, value, current_user)
     @debate.create_activity :vote, owner: current_user
     redirect_to :back, notice: "Thank you for voting"
  end
  
  def publish
      @debate = Debate.find(params[:id])
      @debate.publish
      redirect_to debate_path(@debate)
  end
  
  def follow
    @debate = Debate.find(params[:id])
    if current_user
      current_user.follow(@debate)
      @debate.create_activity :follow, owner: current_user
      redirect_to :back
      flash[:notice] = "You are now following #{@debate.title}."
    else
      flash[:error] = "You must <a href='/users/sign_in'>login</a> to follow #{@debate.title}.".html_safe
    end
  end
  
  def unfollow
    @debate = Debate.find(params[:id])
    if current_user
      current_user.stop_following(@debate)
      redirect_to :back
      flash[:notice] = "You are no longer following #{@debate.title}."
    else
      flash[:error] = "You must <a href='/users/sign_in'>login</a> to unfollow #{@debate.title}.".html_safe
    end
  end
  
   private

    def allowed
      @debate = Debate.find(params[:id])
      if @debate.state == "offline"
        redirect_to(root_path) unless current_user.try(:admin?)
      end
    end
    
    def verify_is_admin
       (current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.try(:admin?))
     end
     
end