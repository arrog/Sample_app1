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
  
end