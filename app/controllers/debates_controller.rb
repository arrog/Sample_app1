class DebatesController < ApplicationController
  
 
  def index
    @debates = Debate.paginate(page: params[:page])
  end
  
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
      Debate.find(params[:id]).destroy
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
  
end