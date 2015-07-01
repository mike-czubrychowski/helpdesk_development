class TicketUserAssignmentsController < ApplicationController

  #load_and_authorize_resource 
  before_action :set_ticket_user_assignment, only: [:show, :edit, :update, :destroy]

  # GET /ticket/users
  def index
    @ticket_user_assignments = TicketUserAssignment.inclusive
    authorize @ticket_user_assignments
  end

  # GET /ticket/users/1
  def show
  end

  # GET /ticket/users/new
  def new
    @ticket_user_assignment = TicketUserAssignment.new
    authorize @ticket_user_assignment
  end

  # GET /ticket/users/1/edit
  def edit
  end

  # POST /ticket/users
  def create
    @ticket_user = TicketUserAssignment.new(ticket_user_assignment_params)
    authorize @ticket_user_assignment
    if @ticket_user_assignment.save
      redirect_to edit_ticket_detail_path(@ticket_user_assignment.ticket_detail)
    else
      render :new
    end
  end

  # PATCH/PUT /ticket/users/1
  def update
    if @ticket_user_assignment.update(ticket_user_assignment_params)
      redirect_to edit_ticket_detail_path(@ticket_user_assignment.ticket_detail), notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /ticket/users/1
  def destroy
    @ticket_user_assignment.destroy
    redirect_to @ticket_user_assignment.ticket_detail, notice: 'User was successfully removed from ticket.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket_user_assignment
      @ticket_user_assignment = TicketUserAssignment.inclusive.find(params[:id])
      authorize @ticket_user_assignment
    end

    # Only allow a trusted parameter "white list" through.
    def ticket_user__assignment_params
      params.require(:ticket_user_assignment).permit(:ticket_detail_id, :user_id)
    end
end
