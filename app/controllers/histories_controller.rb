class HistoriesController < ApplicationController

  def create
    #binding.pry
    Historie.create historie_params
    redirect_to "/lender/#{@user.id}"
  end

  def destroy
    @historie = Historie.find(params[:id])
    @historie.destroy if current_user === @historie.user
    redirect_to "/lender/#{@user.id}"
  end

  private
    def historie_params
      params.require(:historie).permit(:borrower_id).merge(lender: current_user)
    end


end
