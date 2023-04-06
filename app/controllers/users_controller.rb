class UsersController < ApplicationController
  def index
    @users = User.all
  end
  def create
    if @current_user.manager?
      @user = User.new(@request[:body])
      if @user.save
        {status: [201, "Created"], body: {message: 'User created successfully'}}
      else
        {status: [422, "Unprocessable Entity"], body: {message: 'Invalid username or password'}}
      end
    else
      {status: [401, "Unauthorized"], body: {message: 'Unauthorized'}}
    end
  end
end
