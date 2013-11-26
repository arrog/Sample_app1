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

  def show
    @relationship = Relationship.find(params[:id])
  end
  
  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_to do |format|
          format.html { redirect_to @user }
          format.js
        end
  end
  
  def accepter
     @relationship = Relationship.find(params[:id])
     @relationship.accepter
     redirect_to :back
  end
   
  def rejeter
     @relationship = Relationship.find(params[:id])
     @relationship.rejeter
     redirect_to :back
  end
  
  
  private


  def correct_user
    @user = Relationship.find(params[:id]).reciever
    redirect_to(root_path) unless current_user == (@user)
  end
  
end