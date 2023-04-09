class ReimbursementsController < ApplicationController
  include Authenticatable
  #this works at the moment
  def index
    puts "user role is: #{current_user}"
    return render json: {error: "No authorized principal"}, status: :unauthorized unless current_user
    if current_user&.manager?
      @reimbursement = Reimbursement.all
      puts @reimbursement.inspect
      {status: [201, "Displayed reimbursement"]}
      render json: {reimbursement: Reimbursement}
    else
      @reimbursement =Reimbursement.find_by(user_id: current_user.id)
      puts Reimbursement.inspect
      {status: [201, "Displayed reimbursement"]}
      render json: {reimbursement: Reimbursement}
    end
  end
  def destroy
    if current_user.manager?
      if @reimbursement
        reimbursement = Reimbursement.where(id: @reimbursement[:body]['id']).first
        reimbursement.delete if reimbursement
        {status: [201, "Deleted"]}
      else
        {status: [204, "No content"], body: {message: 'Deleted'}}
      end
    else
      if @reimbursement
        reimbursement = current_user.Reimbursement.where(id: @reimbursement[:body]['id']).first
        reimbursement.delete if reimbursement
        {status: [201, "Deleted"]}
      else
        {status: [204, "No content"], body: {message: 'Deleted'}}
      end
    end
    #redirect_to @reimbursement
  end


  def update
    @old_reimbursement = Reimbursement.where(id: @reimbursements[:body]['id']).first
    puts "Updating request #{@old_reimbursement.id}"
    @old_reimbursement.delete
    @new_reimbursement = Reimbursement.new(@reimbursements[:body])
    {body: {amount: @new_reimbursement.amount}}
    if @new_reimbursement.save
      {status: [201, "Updated"]}
    else
      {status: [401, "Unauthorized"], body: {message: 'Invalid username or password'}}
    end
  end

  def create # POST /users/:user_id/lists
    data = JSON.parse(request.body.read)
    data[:user_id] = current_user.id
    @reimbursement = Reimbursement.new(data)
    if @reimbursement.save
      render json: { reimbursement: @reimbursement }, status: :created
    else
      render json: @reimbursement.errors, status: :unprocessable_entity
    end
  end

  private
  def reimbursement_params
    params.require(:reimbursement).permit(:amount, :description, :status)
  end


end
