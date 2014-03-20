class NotesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin_user,   only: [:accept, :reject]
  

  
  def create
    @note = Note.new(params[:note])
    if @note.save
      flash[:success] = "ok!"
      redirect_to :back
    else
      falsh[:error] = "ca a foire!"
      redirect_to :back
    end
  end
  
   private

   def admin_user
     @group = Membership.find(params[:id]).group
     redirect_to(root_path) unless current_user.admin_group?(@group)
   end


end