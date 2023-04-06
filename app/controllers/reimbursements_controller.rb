class ReimbursementsController < ApplicationController
  def index
    @reimbursements = Reimbursement.all
    if @reimbursement
      {status: [201, "Success"]}
    else
      {status: [401, "Unauthorized"], body: {message: 'Unauthorized'}}
    end
  end

  def show
    if @current_user.manager?
      @reimbursement = reimbursement.all
      puts @reimbursement.inspect
      {status: [201, "Displayed reimbursement"]}
      json body: {reimbursement: reimbursement}, headers: cors
    else
      @reimbursement = current_user.reimbursement.all
      puts reimbursement.inspect
      {status: [201, "Displayed reimbursement"]}
      json body: {reimbursement: reimbursement}, headers: cors
    end
  end
  def destroy
    if @current_user.manager?
      if @reimbursements
        reimbursement = Reimbursement.where(id: @reimbursements[:body]['id']).first
        reimbursement.delete if reimbursement
        {status: [201, "Deleted"]}
      else
        {status: [204, "No content"], body: {message: 'Deleted'}}
      end
    else
      if @reimbursements
        reimbursement = current_user.reimbursement.where(id: @reimbursements[:body]['id']).first
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
    {body: {amount: new_reimbursement.amount}}
    if @new_reimbursement.save
      {status: [201, "Updated"]}
    else
      {status: [401, "Unauthorized"], body: {message: 'Invalid username or password'}}
    end
  end

  def new
    @reimbursement = Reimbursement.new(@request[:body])
    if @reimbursement.save
      {status: [201, "Created"], body: {message: 'Request created successfully'}}
    else
      {status: [422, "Unprocessable Entity"], body: {message: 'Invalid username or password'}}
    end
  end

  def create
    @reimbursement = current_user.reimbursement.new(reimbursement_params)
    if @reimbursement.save
      {status: [201, "Created"], body: {message: 'Request created successfully'}}
    else
      {status: [422, "Unprocessable Entity"], body: {message: 'Invalid username or password'}}
    end
  end

  private
  def reimbursement_params
    params.require(:reimbursement).permit(:amount, :description, :status)
  end


end
