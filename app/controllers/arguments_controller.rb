class ArgumentsController < ApplicationController
 before_filter :load_argumentable
 before_filter :signed_in_user, only: [:new, :create, :destroy]
 

  def new
    @argument = @argumentable.arguments.new
  end
  
  def show
    @argument = Argument.find(params[:id])
    @argcoms = @argument.argcoms
    @argcom = @argument.argcoms.new
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
  
  
  def like
    value = params[:type] == "up" ? 1 : -1
    @argument = Argument.find(params[:id])
    @argument.add_or_update_evaluation(:likes, value, current_user)
    redirect_to :back, notice: "Thank you for liking"
  end
  
  
  private

    def load_argumentable
      resource, id = request.path.split('/')[1, 2]
      @argumentable = resource.singularize.classify.constantize.find(id)
    end
    
    
end
