class AuthController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to home
    else
      redirect_to new
    end
  end

  def destroy
    session.reset!
    redirect_to new
  end
end
