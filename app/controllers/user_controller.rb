class UserController < ApplicationController
  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.page(1).per(10)
  end
  
  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:name, :email, :password, :password_confirmation)
    @user = User.create(user_params)
    redirect_to new_auth
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    user_params = params.require(:user).permit(:icon)
    @user.update(user_params)
    redirect_to @user
  end
end
