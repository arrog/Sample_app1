class CommentsController < ApplicationController
  before_filter :load_commentable
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy

  def create
        @commment = @commentable.comments.new(params[:comment])
        @commment.user = current_user
        @argumentable = @commentable.argumentable #A changer si mon commentable n'est pas argumentable
        if @comment.save
          flash[:success] = "Comment created!"
          redirect_to @argumentable
        end
  end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end
  
  
  private

      def correct_user
        @comment = current_user.comments.find_by_id(params[:id])
        redirect_to root_url if @comment.nil?
      end
      
      def load_commentable
        resource, id = request.path.split('/')[1, 2]
        @commentable = resource.singularize.classify.constantize.find(id)
      end
  
  
end