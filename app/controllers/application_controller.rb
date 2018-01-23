class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :loged_in?

  def current_user
    @user = User.find_by(id: session[:user_id])
    if @user != nil
      @user
    else
      nil
    end
  end

  def loged_in?
    session[:user_id] != nil
  end
end
