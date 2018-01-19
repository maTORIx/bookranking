module ApplicationHelper
  def current_user
    User.find(session[:user_id])
  end

  def loged_in?
    session[:user_id] != nil
  end
end
