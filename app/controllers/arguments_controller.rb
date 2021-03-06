class ArgumentsController < ApplicationController
 before_filter :load_argumentable, except: [:edit, :destroy, :new, :index]
 before_filter :authenticate_user!, only: [:new, :edit, :create, :destroy, :like]
 before_filter :correct_user, only: [:edit]
 before_filter :verify_is_admin,  only: [:index]
 
  def new
    @argument = Argument.new
  end
  
  def show
    @argument = Argument.find(params[:id])
    @argcoms = @argument.argcoms
  end
  
  def index
    @arguments= Argument.all
  end

  def create
      @argument = @argumentable.arguments.new(params[:argument])
      @argument.user = current_user
      if @argument.save
        if @argumentable.class == Debate
            @argument.create_activity :create, owner: current_user
        elsif @argumentable.class == Challenge
            if @argumentable.last_speaker?
               @argumentable.next
            else    
              @user = @argumentable.speaking
              ChallengeMailer.new_argument(@user, @argumentable).deliver
            end
        end
        flash[:success] = "Tu argumentes!"
        redirect_to @argumentable
      else
        flash[:errors]
        render "edit" 
      end
  end
  
  def edit 
     @argument = Argument.find(params[:id])
   end

  def update
    @argument = Argument.find(params[:id])
       if @argument.update_attributes(params[:argument])
         flash[:success] = "argument updated"
              redirect_to @argument.argumentable
       else
         render 'edit'
       end
  end
  
  def destroy
      Argument.find(params[:id]).destroy
      flash[:success] = "argument deleted."
      redirect_to :back
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
    
    def correct_user
          @user = Argument.find(params[:id]).user
          if current_user == @user
          elsif current_user.admin?
          elsif
            redirect_to(root_path)
          end
    end
    
    def verify_is_admin
       (current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.try(:admin?))
    end
    
end
