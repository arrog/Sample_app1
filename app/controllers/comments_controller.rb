class CommentsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy
  

  def create
        @comment = Comment.new(params[:comment])
        @comment.user = current_user
        if @comment.save
          flash[:success] = "Comment created!"
          redirect_to :back
        else
          render 'static_pages/home'
        end
  end

  def destroy
    @comment.destroy
    redirect_to :back
  end

  def like_comment
    value = params[:type] == "up" ? 1 : -1
    @comment = Comment.find(params[:id])
    @comment.add_or_update_evaluation(:like_comment, value, current_user)
    redirect_to :back, notice: "Thank you for liking"
  end  
  
  private

      def correct_user
        @comment = current_user.comments.find_by_id(params[:id])
        redirect_to root_url if @comment.nil?
      end
   
end
