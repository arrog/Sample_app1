class ArgumentsController < ApplicationController
 before_filter :load_argumentable
 before_filter :authenticate_user!, only: [:new, :create, :destroy, :like]

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
        if @argumentable.class == "Debate"
            @argument.create_activity :create, owner: current_user
        end
        flash[:success] = "Tu argumentes!"
        redirect_to @argumentable
      else
        flash[:errors]
        redirect_to :back
      end
  end
  
  
  def like
    value = params[:type] == "up" ? 1 : -1
    @argument = Argument.find(params[:id])
    @argument.add_or_update_evaluation(:likes, value, current_user)
    @argument.create_activity :vote, owner: current_user
    redirect_to :back, notice: "Thank you for liking"
  end
  
  
  private

    def load_argumentable
      resource, id = request.path.split('/')[1, 2]
      @argumentable = resource.singularize.classify.constantize.find(id)
    end
    
    
end
