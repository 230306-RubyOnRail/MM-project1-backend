class User < ApplicationRecord
  belongs_to :role
  has_secure_password
  def manager?
    @user.role_id == 'manager'
  end

  def self.digest(password)
    BCrypt::Password.create(password)
  end
end
