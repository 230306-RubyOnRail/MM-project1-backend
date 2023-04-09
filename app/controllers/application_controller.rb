
class ApplicationController < ActionController::API
  def manager?
    @user.role_id == 'manager'
  end


end
