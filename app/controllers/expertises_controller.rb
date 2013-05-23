class ExpertisesController < ApplicationController
  #before_filter :load_doulin
  before_filter :authenticate_user!
  before_filter :verify_is_admin
  
  def new
    @expertise = Expertise.new
  end
  
  def create
    @expertise = Expertise.new(params[:expertise])
    if @expertise.save
      flash[:success] = "You created a new debate!"
      redirect_to :back
    else
      render 'new'
    end
  end
  
  def show
    @expertise = Expertise.find(params[:id])
  end
  
   private

   def verify_is_admin
      (current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.try(:admin?))
   end
   
   #def load_doulin
    # resource, id = request.path.split('/')[1, 2]
     #@doulin = resource.singularize.classify.constantize.find(id)
   #end
     
end