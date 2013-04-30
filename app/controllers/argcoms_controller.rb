class ArgcomsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,   only: :destroy


  def create
      @argcom = current_user.argcoms.build(params[:argcom])
      @argument = @argcom.argument
        if @argcom.save
          flash[:success] = "Comment created!"
          redirect_to @argument
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