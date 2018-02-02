class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user
    return @current_user if instance_variable_defined?(:@current_user)

    @current_user = User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def user_only
    if !loged_in?
      redirect_to "/signin"
    end
  end
end
