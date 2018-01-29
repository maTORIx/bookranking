class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :loged_in?

  def current_user
    return User.find_by(id: session[:user_id])
  end

  def loged_in?
    session[:user_id] != nil
  end

  def user_only
    if !loged_in?
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end
end
