class InvitationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user,   only: [:show, :accept, :reject]
  
  def index
    @invitations = current_user.reverse_invitations.where(:state => "unseen")
  end
  
  def show
    @invitation = Invitation.find(params[:id])
  end
  
  def create
    @invitation = Invitation.new(params[:invitation])
    if @invitation.save
      flash[:success] = "You invited him"
      redirect_to :back
    else
      redirect_to :back
    end
  end
  
  def accept
     @invitation = Invitation.find(params[:id])
     @challenge = @invitation.challenge
     @invitation.accept
     redirect_to :back
  end
   
  def reject
     @invitation = Invitation.find(params[:id])
     @challenge = @invitation.challenge
     @invitation.reject
     redirect_to :back
  end 
  
   private


   def correct_user
     @user = Invitation.find(params[:id]).reciever
     redirect_to(root_path) unless current_user == (@user)
   end
  
end