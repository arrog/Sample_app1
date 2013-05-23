class ChallengesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  
  def new
    @challenge = Challenge.new
  end
  
  def create
      @challenge = Challenge.new(params[:challenge])
      ch = @challenge
      if @challenge.save
        flash[:success] = "You created a new debate!"
        redirect_to @challenge
      else
        render 'new'
      end      
  end
    
  def show
      @challenge = Challenge.find(params[:id])
      @performance = @challenge.performances.build
      @argumentable = @challenge
      @commentable = @challenge
      @arguments = @argumentable.arguments
      @judgments = @challenge.judgments
      @comments = @commentable.comments
      @comment = @commentable.comments.new
      if signed_in?
        @argument=current_user.arguments.new
      end
  end
  
  def edit 
  end
  
  
  def index
    if params[:cat] && !params[:cat].empty?
      @current_category = Cat.find(params[:cat])
      @challenges = Challenge.where(:cat_id => @current_category.id)
    else
      @challenges = Challenge.all
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
  
  def starting
    @challenge = Challenge.find(params[:id])
    @challenge.starting
    redirect_to challenge_path(@challenge)
  end
    
  def finish
     @challenge = Challenge.find(params[:id])
     @challenge.finish
     redirect_to challenge_path(@challenge)
  end

  def grade
    @challenge = Challenge.find(params[:id])
    @challenge.grade
    redirect_to challenge_path(@challenge)
  end
  
  def join_one
    @challenge = Challenge.find(params[:id])
    current_user.join_position_one!(@challenge)
    redirect_to @challenge
  end
  
  def join_two
    @challenge = Challenge.find(params[:id])
    current_user.join_position_two!(@challenge)
    redirect_to @challenge
  end
  
  def join_three
    @challenge = Challenge.find(params[:id])
    current_user.join_position_three!(@challenge)
    redirect_to @challenge
  end
  
  def join_four
    @challenge = Challenge.find(params[:id])
    current_user.join_position_four!(@challenge)
    redirect_to @challenge
  end
  
  def join_five
    @challenge = Challenge.find(params[:id])
    current_user.join_position_five!(@challenge)
    redirect_to @challenge
  end
  
  def join_six
    @challenge = Challenge.find(params[:id])
    current_user.join_position_six!(@challenge)
    redirect_to @challenge
  end
  
  def join_seven
    @challenge = Challenge.find(params[:id])
    current_user.join_position_seven!(@challenge)
    redirect_to @challenge
  end
  
  def join_eight
    @challenge = Challenge.find(params[:id])
    current_user.join_position_eight!(@challenge)
    redirect_to @challenge
  end
  
  def join_judge
    @challenge = Challenge.find(params[:id])
    current_user.join_position_judge!(@challenge)
    redirect_to @challenge
  end
  
   private
         
       def authorized_user
         @micropost = current_user.microposts.find_by_id(params[:id])
         redirect_to root_url if @micropost.nil?
       end
  
end