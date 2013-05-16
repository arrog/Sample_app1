class JudgmentsController < ApplicationController

  before_filter :authenticate_user!, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy

  def create
        @judgment = current_user.judgments.build(params[:judgment])
        if @judgment.save
          flash[:success] = "Judgment created!"
          redirect_to root_url
        else
          render new
        end
  end

  def destroy
    @judgment.destroy
    redirect_to root_url
  end
  
  
  private

      def correct_user
        @judgment = current_user.judgments.find_by_id(params[:id])
        redirect_to root_url if @judgment.nil?
      end
  
  

end