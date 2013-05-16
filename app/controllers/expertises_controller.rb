class ExpertisesController < ApplicationController
  
  before_filter :authenticate_user!
  
  def create
    @expertise = performances.build(params[:performance])
    if @performance.save
      flash[:success] = "You created a new debate!"
      redirect_to_previous_page
    else
      render 'new'
    end
  end
  
    
end