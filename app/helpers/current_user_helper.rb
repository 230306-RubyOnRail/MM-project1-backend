module CurrentUserHelper
  def current_user_helper
    def manager?
      current_user.role == 'manager'
    end
  end
end
