class ReimbursementsController < ApplicationController
  include Authenticatable
  #this works at the moment
  def index
        return render json: {error: "No authorized principal"}, status: :unauthorized unless current_user
        if current_user&.manager?
          @reimbursement = Reimbursement.all
          puts @reimbursement.inspect
          {status: [201, "Displayed reimbursement"]}
          render json: {reimbursement: @reimbursement}
        else
          {status: [401, "Unauthorized"], body: ["No permissions"]}
      render json: {reimbursement: @reimbursement}
    end
  end

  def show
    @reimbursement =Reimbursement.where(user_id: params[:id])
    puts @reimbursement.inspect
    {status: [201, "Displayed reimbursement"]}
    render json: {reimbursement: @reimbursement}
  end
  def destroy
    return render json: {error: "No authorized principal"}, status: :unauthorized unless current_user
    if current_user&.manager?
      @reimbursement = Reimbursement.where(id: params[:id]).first
      if @reimbursement
        @reimbursement.delete if @reimbursement
        {status: [201, "Deleted"]}
      else
        {status: [204, "No content"], body: {message: 'Deleted'}}
      end
    else
      @reimbursement = current_user&.Reimbursement.where(id: params[:id]).first
      if @reimbursement
        @reimbursement.delete if @reimbursement
        {status: [201, "Deleted"]}
      else
        {status: [204, "No content"], body: {message: 'Deleted'}}
      end
    end
    #redirect_to @reimbursement
  end


  def update
    @reimbursement = Reimbursement.where(id: params[:id]).first
    puts "Updating request #{@reimbursement}"
    @reimbursement.update(JSON.parse(request.body.read))
    {body: {amount: @reimbursement.amount}}
    if @reimbursement.save
      {status: [201, "Updated"]}
    else
      {status: [401, "Unauthorized"], body: {message: 'Invalid username or password'}}
    end
  end

  def create # POST /users/:user_id/lists
    return render json: {error: "No authorized principal"}, status: :unauthorized unless current_user
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
