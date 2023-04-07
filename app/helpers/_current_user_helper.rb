module CurrentUserHelper
  def current_user_helper
    def manager?
      @user.role_id == 'manager'
    end
  end
end
