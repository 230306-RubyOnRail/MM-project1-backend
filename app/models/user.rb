class User < ApplicationRecord
  def authenticate(un, pass)
    user=find_by(username:un, password:pass)
    if user
      return true
    else
      return false
    end
  end
end
