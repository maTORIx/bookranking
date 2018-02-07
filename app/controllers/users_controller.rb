class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.page(1).per(10)
    @books = @user.books.page(1).per(10)
  end
  
  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:name, :email, :password, :password_confirmation)
    @user = User.create(user_params)
    #UserMailer.email_confirm(@user).deliver
    redirect_to new_auth_url
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

  def confirm
    @user = User.find(params[:user_id])
    if params[:confirm_hash] == @user.confirm_hash
      @user.confirmed = true
      @user.save!
      redirect_to new_auth_url and return
    else
      render file: "#{Rails.root}/public/500.html", layout: false, status: 500 and return
    end
  end

  def confirm_email
    @user = User.find(params[:email])
    UserMailer.email_confirm(@user).deliver
    redirect_to new_auth_url
  end

end
