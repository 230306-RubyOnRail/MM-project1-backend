
class ApplicationController < ActionController::API
  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end
  def manager?
    @user.role_id == 'manager'
  end


end
