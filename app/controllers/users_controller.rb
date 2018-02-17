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
    if User.create(user_params)
      @notifies = []
      @notifies.push("エラーが発生しました")
      @notifies.push("同じメールアドレスは登録できません") if User.exists?(email: user_params[:email])
      redirect_to new_user_url, flash: {notifies: @notifies} and return
    end
    redirect_to new_auth_url, flash: {notifies: ["ユーザーを作成しました。認証メールを確認してください"]}
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
      redirect_to new_auth_url, flash: {notifies: ["メールの認証を完了しました"]}
    else
      render redirect_to new_auth_url, flash: {notifies: ["認証のエラーが起きました。認証メールの再送信を推奨します"]}
    end
  end

  def confirm_email
    @user = User.find_by(email: params[:email])
    if !@user.confirmed
      @user.email_confirm 
      redirect_to new_auth_url, flash: {notifies: ["認証メールを再送信しました"]}
    else
      redirect_to new_auth_url, flash: {notifies: ["すでにメール認証を行っています"]}
    end
  end

end
