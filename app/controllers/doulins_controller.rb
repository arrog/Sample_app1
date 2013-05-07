class DebatesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
 
  def index
    @doulins = Doulin.paginate(page: params[:page])
  end
  
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
      @arguments = @argumentable.arguments
      @argument = Argument.new
      @argcom  = current_user.argcoms.build
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
      Doulin.find(params[:id]).destroy
      flash[:success] = "Debate deleted."
      redirect_to debates_url
  end
  
  
  def vote_expert
     value = params[:type] == "up" ? 1 : -1
     @debate = Debate.find(params[:id])
     @debate.add_or_update_evaluation(:votes, value, current_user)
     redirect_to :back, notice: "Thank you for voting"
   end
  
end