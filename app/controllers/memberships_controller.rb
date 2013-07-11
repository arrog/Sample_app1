class MembershipsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin_user,   only: [:accept, :reject]
  
  def accept
     @membership = Membership.find(params[:id])
     @membership.accept
     redirect_to :back
  end
   
  def reject
     @membership = Membership.find(params[:id])
     @membership.reject
     redirect_to :back
   end 
  
  def create
    @membership = Membership.new(params[:membership])
    if @membership.save
      flash[:success] = "Invité!"
      redirect_to :back
    else
      falsh[:error] = "ça a foiré!"
      redirect_to :back
    end
  end
  
   private

   def admin_user
     @group = Membership.find(params[:id]).group
     redirect_to(root_path) unless current_user.admin?(@group)
   end


end