class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def index
  end

  def new
    #goto logon form
  end

  def create
    #binding.pry
    @lender = Lender.find_by_email(params[:email]).try(:authenticate, params[:password])

    if @lender
      session[:user_id] = @lender.id
      #redirect_to "/dashboard/#{@user.id}"
      redirect_to "/lender/#{@lender.id}"
    else
      @borrower = Borrower.find_by_email(params[:email]).try(:authenticate, params[:password])
      session[:user_id] = @borrower.id
      #puts 'Create Error'
      #flash[:errorsLogin] = ["Invalid Email or PW"]
      # redirect_to :back
      redirect_to "/borrower/#{@borrower.id}"
    end

  end

  def destroy
    reset_session
    redirect_to "/users/new"
  end
end
