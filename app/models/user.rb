class User < ApplicationRecord
  belongs_to :role
  has_secure_password
  def manager?
    self.role_id == 1
  end

  def self.digest(password)
    BCrypt::Password.create(password)
  end
end
