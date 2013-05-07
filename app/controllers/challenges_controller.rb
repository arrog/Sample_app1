class ChallengesController < ApplicationController
  before_filter ::authenticate_user!, except: [:index, :show]
 
  def index
    @challenges = Challenge.paginate(page: params[:page])
  end
  
  def new
    @challenge = Challenge.new
  end
  
  def create
      @challenge = Challenge.new(params[:challenge])
      if @debate.save
        flash[:success] = "You created a new debate!"
        redirect_to @challenge
      else
        render 'new'
      end      
  end
    
  def show
      @challenge = Challenge.find(params[:id])
      @argumentable = @challenge
      @arguments = @argumentable.arguments
      @argument = current_user.arguments.new
  end
  
  def edit 
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
      Challenge.find(params[:id]).destroy
      flash[:success] = "Debate deleted."
      redirect_to debates_url
  end
  
  
  def vote
     value = params[:type] == "up" ? 1 :
        value = params[:type] == "down" ? -1 : 0
     @debate = Debate.find(params[:id])
     @debate.add_or_update_evaluation(:votes, value, current_user)
     redirect_to :back, notice: "Thank you for voting"
   end
  
  
   private

       def authorized_user
         @micropost = current_user.microposts.find_by_id(params[:id])
         redirect_to root_url if @micropost.nil?
       end
  
end