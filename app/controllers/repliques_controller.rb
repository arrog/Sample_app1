class RepliquesController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy

  def create
        @replique = Replique.new(params[:replique])
        @replique.user = current_user
        if @replique.save
          flash[:success] = "replique created!"
          redirect_to :back
        else
          render @replicable
        end
  end

  def destroy
    @replique.destroy
    redirect_to :back
  end
  
  
  private

      def correct_user
        @replique = current_user.repliques.find_by_id(params[:id])
        redirect_to root_url if @replique.nil?
      end
  
end
