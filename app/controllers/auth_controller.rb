class AuthController < ApplicationController

  def new
    @user = User.new
  end

  def create
    login_params = params.require("user").permit(:email, :password)
    @user = User.find_by(email: login_params[:email])

    if @user == nil
      redirect_to new_auth_url(notifies: ["メールアドレスかパスワードが間違っています"])
    elsif !@user.confirmed
      redirect_to new_auth_url(notifies: ["メール認証がされていないとログインできません"])
    elsif @user && @user.authenticate(login_params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_to new_auth_url(notifies: ["メールアドレスかパスワードが間違っています"])
    end
  end

  def destroy
    session.clear
    redirect_to new_auth_url
  end
end
