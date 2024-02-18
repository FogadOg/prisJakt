class LoginController < ApplicationController
  before_action :redirectLoggedInUser, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(name: params[:name], password: params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_url, notice: 'Logged in successfully!'
    else

      flash.now[:alert] = 'Invalid name or password'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Logged out successfully!'
  end
end
