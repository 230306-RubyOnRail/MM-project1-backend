class ReimbursementsController < ApplicationController

  def index
    @reimbursements = Reimbursement.all
  end


  def destroy
    @reimbursement = Reimbursement.find(params[:id])
    @reimbursement.destroy
    redirect_to @reimbursement
  end

  def edit
    @reimbursement = Reimbursement.find(params[:id])
  end

  def update
    @reimbursement = Reimbursement.find(params[:id])
    if @reimbursement.update(reimbursement_params)
      redirect_to @reimbursement
    else
      #edit instead of update??
      render :update, status: :unprocessable_entity
    end
  end

  def new
    @reimbursement = current_user.reimbursement.new
  end

  def create
    @reimbursement = current_user.reimbursement.new(reimbursement_params)
    if @reimbursement.save
      redirect_to @reimbursement
    else
      #new instead of update??
      render :update, status: :unprocessable_entity
    end
  end

  private

  def reimbursement_params
    params.require(:reimbursement).permit(:amount, :description, :status)
  end



end
