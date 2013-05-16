class PerformancesController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    @performance = current_user.performances.build(params[:performance])
    if @performance.save
      flash[:success] = "You created a new debate!"
      redirect_to_previous_page
    else
      render 'new'
    end
  end
  
  private

    def load_performancable
     resource, id = request.path.split('/')[1, 2]
      @challenge = resource.singularize.classify.constantize.find(id)
    end
    
    
end