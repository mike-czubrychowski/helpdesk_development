class Ticket::UserAssignmentsController < ApplicationController
  before_action :set_ticket_user_assignment, only: [:show, :edit, :update, :destroy]

  # GET /ticket/users
  def index
    @ticket_user_assignments = Ticket::UserAssignment.all
  end

  # GET /ticket/users/1
  def show
  end

  # GET /ticket/users/new
  def new
    @ticket_user_assignment = Ticket::UserAssignment.new
  end

  # GET /ticket/users/1/edit
  def edit
  end

  # POST /ticket/users
  def create
    @ticket_user = Ticket::UserAssignment.new(ticket_user_assignment_params)

    if @ticket_user_assignment.save
      redirect_to @ticket_user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /ticket/users/1
  def update
    if @ticket_user_assignment.update(ticket_user_assignment_params)
      redirect_to @ticket_user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /ticket/users/1
  def destroy
    @ticket_user_assignment.destroy
    redirect_to ticket_users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket_user_assignment
      @ticket_user_assignment = Ticket::UserAssignment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ticket_user__assignment_params
      params.require(:ticket_user_assignment).permit(:ticket_detail_id, :user_id)
    end
end
