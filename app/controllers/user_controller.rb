class UserController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:name, :email, :password, :password_confirmation)
    @user = User.create(user_params)
    redirect_to new_auth
  end
end
