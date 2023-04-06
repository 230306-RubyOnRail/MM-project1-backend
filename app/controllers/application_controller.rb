require_relative '../helpers/current_user_helper'
class ApplicationController < ActionController::API
  include current_user_helper
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  current_user_helper :@current_user


end
