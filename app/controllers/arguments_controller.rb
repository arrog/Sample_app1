class ArgumentsController < ApplicationController
 before_filter :load_argumentable
 before_filter :signed_in_user, only: [:create, :destroy]
 
  def index
    @arguments = @argumentable.arguments
  end

  def new
    @argument = @argumentable.arguments.new
  end
  
  def create
      @argument = @argumentable.arguments.new(params[:argument])
      @argument.user = current_user
      if @argument.save
        flash[:success] = "Tu argumentes!"
        redirect_to @argumentable
      else
        render :new
      end
  end
  
  
  
  private

    def load_argumentable
      resource, id = request.path.split('/')[1, 2]
      @argumentable = resource.singularize.classify.constantize.find(id)
    end
    
    
end
