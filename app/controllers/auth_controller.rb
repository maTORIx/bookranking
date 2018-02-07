class AuthController < ApplicationController

  def new
    @user = User.new
  end

  def create
    login_params = params.require("user").permit(:email, :password)
    @user = User.find_by(email: login_params[:email])
    if !@user.confirmed
      @notifies = ["メール認証がされていないとログインできません"]
      redirect_to new_auth_url(notifies: @notifies)
    elsif @user && @user.authenticate(login_params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      @notifies = ["メールアドレスかパスワードが間違っています"]
      redirect_to new_auth_url(notifies: @notifies)
    end
  end

  def destroy
    session.clear
    redirect_to new_auth_url
  end
end
