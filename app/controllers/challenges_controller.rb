class ChallengesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :verify_is_admin,  only: [:edit, :destroy, :update, :index]
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
      @argumentable = @challenge
      @commentable = @challenge
      @arguments = @argumentable.arguments
      @judgments = @challenge.judgments
      @comments = @commentable.comments
      if signed_in?
        @argument = current_user.arguments.new
      end
  end
  
  def update
    @challenge = Challenge.find(params[:id])
       if @challenge.update_attributes(params[:challenge])
         flash[:success] = "Profile updated"
              redirect_to @challenge
       else
         render 'edit'
       end
  end
  
  def edit
      @challenge = Challenge.find(params[:id])
  end
  
  def vote_challenge
     value = params[:type] == "up" ? 1 :
      value = params[:type] == "down" ? -1 : 
         value = params[:type] == "upup" ? 2 :-2
     @challenge = Challenge.find(params[:id])
     @challenge.add_or_update_evaluation(:vote_challenges, value, current_user)
     @challenge.create_activity :vote, owner: current_user
     redirect_to :back, notice: "Thank you for voting"
     
   end
  
  
   def index
     @challenges = Challenge.order("title").page(params[:page]).per_page(5)
    end

  def destroy
      Challenge.find(params[:id]).destroy
      flash[:success] = "Debate deleted."
      redirect_to root_path
  end
  
  
  def promote
    @challenge = Challenge.find(params[:id])
    @challenge.promote
    redirect_to challenge_path(@challenge)
  end
  
  def starting
    @challenge = Challenge.find(params[:id])
    @challenge.starting
    redirect_to challenge_path(@challenge)
  end
  
  def next
    @challenge = Challenge.find(params[:id])
    @challenge.next
    @user = @challenge.speaking
    TourMailer.votre_tour(@user, @challenge).deliver
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
    @challenge.create_activity :join, owner: current_user
    if !@challenge.not_full?
      @user = @challenge.prime_minister
      ChallengeMailer.new_argument(@user, @challenge).deliver
    end
    redirect_to @challenge
  end
  
  def join_two
    @challenge = Challenge.find(params[:id])
    current_user.join_position_two!(@challenge)
    @challenge.create_activity :join, owner: current_user
    if !@challenge.not_full?
      @user = @challenge.prime_minister
      ChallengeMailer.new_argument(@user, @challenge).deliver
    end
    redirect_to @challenge
  end
  
  def join_three
    @challenge = Challenge.find(params[:id])
    current_user.join_position_three!(@challenge)
    @challenge.create_activity :join, owner: current_user
    if !@challenge.not_full?
      @user = @challenge.prime_minister
      ChallengeMailer.new_argument(@user, @challenge).deliver
    end
    redirect_to @challenge
  end
  
  def join_four
    @challenge = Challenge.find(params[:id])
    current_user.join_position_four!(@challenge)
    @challenge.create_activity :join, owner: current_user
    if !@challenge.not_full?
      @user = @challenge.prime_minister
      ChallengeMailer.new_argument(@user, @challenge).deliver
    end
    redirect_to @challenge
  end
  
  def join_five
    @challenge = Challenge.find(params[:id])
    current_user.join_position_five!(@challenge)
    @challenge.create_activity :join, owner: current_user
    if !@challenge.not_full?
      @user = @challenge.prime_minister
      ChallengeMailer.new_argument(@user, @challenge).deliver
    end
    redirect_to @challenge
  end
  
  def join_six
    @challenge = Challenge.find(params[:id])
    current_user.join_position_six!(@challenge)
    @challenge.create_activity :join, owner: current_user
    if !@challenge.not_full?
      @user = @challenge.prime_minister
      ChallengeMailer.new_argument(@user, @challenge).deliver
    end
    redirect_to @challenge
  end
  
  def join_seven
    @challenge = Challenge.find(params[:id])
    current_user.join_position_seven!(@challenge)
    @challenge.create_activity :join, owner: current_user
    if !@challenge.not_full?
      @user = @challenge.prime_minister
      ChallengeMailer.new_argument(@user, @challenge).deliver
    end
    redirect_to @challenge
  end
  
  def join_eight
    @challenge = Challenge.find(params[:id])
    current_user.join_position_eight!(@challenge)
    @challenge.create_activity :join, owner: current_user
    if !@challenge.not_full?
      @user = @challenge.prime_minister
      ChallengeMailer.new_argument(@user, @challenge).deliver
    end
    redirect_to @challenge
  end
  
  def join_judge
    @challenge = Challenge.find(params[:id])
    current_user.join_position_judge!(@challenge)
    @challenge.create_activity :judge, owner: current_user
    redirect_to @challenge
  end
  
  def join_judge_two
    @challenge = Challenge.find(params[:id])
    current_user.join_position_judge_two!(@challenge)
    @challenge.create_activity :judge, owner: current_user
    redirect_to @challenge
  end
  
  def join_judge_three
    @challenge = Challenge.find(params[:id])
    current_user.join_position_judge_three!(@challenge)
    @challenge.create_activity :judge, owner: current_user
    redirect_to @challenge
  end
  
  def follow
    @challenge = Challenge.find(params[:id])
    if current_user
      current_user.follow(@challenge)
      @challenge.create_activity :follow, owner: current_user
      redirect_to :back
      flash[:notice] = "You are now following #{@challenge.title}."
    else
      flash[:error] = "You must <a href='/users/sign_in'>login</a> to follow #{@challenge.title}.".html_safe
    end
  end
  
  def unfollow
    @challenge = Challenge.find(params[:id])
    if current_user
      redirect_to :back
      current_user.stop_following(@challenge)
      flash[:notice] = "You are no longer following #{@challenge.title}."
    else
      flash[:error] = "You must <a href='/users/sign_in'>login</a> to unfollow #{@challenge.title}.".html_safe
    end
  end
  
  private
   
   def verify_is_admin
      (current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.try(:admin?))
   end  
end