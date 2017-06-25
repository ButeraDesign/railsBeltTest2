class BorrowersController < ApplicationController


  def show
    @borrower = Borrower.find(session[:user_id])
    @allLenders = Lender.all
  end

  def create
    puts 'in Borrower create'
    #binding.pry
    @borrower = Borrower.new(user_params)
    #binding.pry

    if @borrower.save
      #binding.pry
      #user created, have them logon now (or maybe log them in and go to show?)
      session[:user_id] = @borrower.id
      #redirect_to "/dashboard/#{@user.id}"
      redirect_to "/login"
    else
      #binding.pry
      puts 'Create Error'
      flash[:errorsUser] = @borrower.errors.full_messages
      # redirect_to :back
      redirect_to "/register"
    end
  end


  private

    def user_params
      params.require(:borrower).permit(:first_name, :last_name, :email, :password, :password_confirmation, :purpose, :money, :description,:raised)
    end

    def require_correct_user
      if current_user != Borrower.find(params[:id])
        redirect_to "/users/#{session[:user_id]}"
      end
    end

end
