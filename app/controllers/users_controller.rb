class UsersController < ApplicationController
  def create

  end
end
def index
  @users = User.all
end