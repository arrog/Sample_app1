class CatsController < ApplicationController
  before_filter :load_cat
  
  def challenges
    @challenges = Challenge.where(cat_id: @cat.id)
  end
  
  private
  
  def load_cat
    resource, id = request.path.split('/')[1, 2]
    @cat = resource.singularize.classify.constantize.find(id)
  end
  
end