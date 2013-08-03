class RelationshipsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user,   only: [:accept, :reject]

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    respond_to do |format|
          format.html { redirect_to @user }
          format.js
        end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_to do |format|
          format.html { redirect_to @user }
          format.js
        end
  end
  
  def accept
     @relationship = Relationship.find(params[:id])
     @challenge = @relationship.challenge
     @relationship.accept
     redirect_to :back
  end
   
  def reject
     @relationship = Relationship.find(params[:id])
     @challenge = @relationship.challenge
     @relationship.reject
     redirect_to :back
  end
  
  private


  def correct_user
    @user = Relationship.find(params[:id]).reciever
    redirect_to(root_path) unless current_user == (@user)
  end
  
end