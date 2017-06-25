class LendersController < ApplicationController

  def create
    puts 'in Lenders create'
    #binding.pry
    @lender = Lender.new(user_params)

    #binding.pry

    if @lender.save
      #user created, have them logon now (or maybe log them in and go to show?)
      #session[:user_id] = @lender.id
      #redirect_to "/dashboard/#{@user.id}"
      redirect_to "/login"
    else
      puts 'Create Error'
      flash[:errorsUser] = @lender.errors.full_messages
      # redirect_to :back
      redirect_to "/register"
    end
  end

  def show
    #binding.pry
    #puts 'In Show'
    @lender = Lender.find(session[:user_id])
    @allBorrowers = Borrower.all;
    @allLenders = Lender.all
    #@allShoes = Shoe.all
    #@shoesForSale = Shoe.all.where(sold: false, seller_id: session[:user_id])
    #@shoesSold = Shoe.all.where(sold: true, seller_id: session[:user_id])
    #@shoesBought = Shoe.all.where(sold: true, buyer_id: session[:user_id])

    #binding.pry
  end


  private

    def user_params
      params.require(:lender).permit(:first_name, :last_name, :email, :password, :password_confirmation, :money)
    end

    def require_correct_user
      if current_user != LendersController.find(params[:id])
        redirect_to "/users/#{session[:user_id]}"
      end
    end
end
