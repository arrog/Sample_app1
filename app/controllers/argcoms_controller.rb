class ArgcomsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user,   only: :destroy


  def create
      @argcom = current_user.argcoms.build(params[:argcom])
        if @argcom.save
          flash[:success] = "Comment created!"
          redirect_to :back 
        else
          render "new"  ##??????
        end
  end

  def destroy
    @argcom.destroy
    redirect_to root_url
  end
  
  
  private
       
      def correct_user
        @argcom = current_user.argcoms.find_by_id(params[:id])
        redirect_to root_url if @argcom.nil?
      end
end