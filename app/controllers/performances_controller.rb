class PerformancesController < ApplicationController
  
  before_filter :signed_in_user
  
  def create
    @user = User.find(params[:performance][:user_id])
    @debate = Debate.find(params[:performance][:debate_id])
    @debate.participate!(@user)
    respond_to do |format|
          format.html { redirect_to @debate }
          format.js
        end
  end

  def destroy
    @user = User.find(params[:performance][:user_id])
    @debate = Debate.find(params[:performance][:debate_id])
    @debate.leave_debate!(@user)
    respond_to do |format|
          format.html { redirect_to @debate }
          format.js
        end
  end
end