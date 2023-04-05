class User < ApplicationRecord
  has_many :reimbursement

  before_save :authenticate
  before_destroy :authenticate
  before_update :authenticate
  before_create :authenticate
  def authenticate(un, pass)
    user=find_by(username:un, password:pass)
    if user
      return true
    else
      return false
    end
  end
end
