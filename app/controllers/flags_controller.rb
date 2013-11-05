class FlagsController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    @flag = Flag.new(params[:flag])
    if @flag.save
      flash[:success] = "Invite!"
      redirect_to :back
    else
      falsh[:error] = "ca a foire!"
      redirect_to :back
    end
  end

end