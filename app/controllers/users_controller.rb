class UsersController < ApplicationController
  def create
    if @user.manager?
      #@user = User.new(@request[:body])
      user = User.new(JSON.parse(request.body.read))
      if user.save
        render json: {user: user}, status: :created
        #{status: [201, "Created"], body: {message: 'User created successfully'}}
      else
        render json: {error:"User Make Failed" }, status: :unprocessable_entity
      end
    else
      render json: {error: "No authorized principal"}, status: :unauthorized
    end
  end
end
