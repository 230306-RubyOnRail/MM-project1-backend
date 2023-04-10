class UsersController < ApplicationController
  include Authenticatable
  def index
    return render json: {error: "No authorized principal"}, status: :unauthorized unless current_user
    if current_user&.manager?
      @user = User.all
      puts @user.inspect
      {status: [201, "Displayed reimbursement"]}
      render json: {user: @user}
    end
  end
  def create
    if current_user&.manager?
      #@user = User.new(@request[:body])
      @user = User.new(JSON.parse(request.body.read))
      if @user.save
        render json: {user: @user}, status: :created
        #{status: [201, "Created"], body: {message: 'User created successfully'}}
      else
        render json: {error:"User Make Failed" }, status: :unprocessable_entity
      end
    else
      render json: {error: "No authorized principal"}, status: :unauthorized
    end
  end
  def destroy
    if current_user&.manager?
      @user = User.where(id: params[:id]).first
      if @user
        @user.delete if @user
        {status: [201, "Deleted"]}
      else
        {status: [204, "No content"], body: {message: 'Deleted'}}
      end
    end
    #redirect_to @reimbursement
  end
end
