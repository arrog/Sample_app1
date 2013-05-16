class AdminsController  < ApplicationController
  before_filter :verify_is_admin
  before_filter :authenticate_user!
  
  def index
   @debate = Debate.new
   @doulin = Doulin.new 
  end
  
  
  def show
  end
  

  private

  def verify_is_admin
    (current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.admin?)
  end

end