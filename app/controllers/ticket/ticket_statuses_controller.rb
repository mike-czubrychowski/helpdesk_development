class TicketStatusesController < ApplicationController

  before_filter :authenticate_user!
  after_action :verify_authorized
  before_action :set_ticket_status, only: [:show, :edit, :update, :destroy]
  

  before_action :calculate_time_taken, only: [:index, :show, :edit]

  def index
    @ticket_statuses = TicketStatus.inclusive
    authorize @ticket_statuses
  end

  def show   
  end

  def new
    @ticket_status = TicketStatus.new
    authorize @ticket_status
  end

  def edit
  end

  def create
    @ticket_status = TicketStatus.new(ticket_status_params)
    authorize @ticket_status
    flash[:notice] = 'Ticket Status was successfully created.' if @ticket_status.save
    respond_with(@ticket_status)
  end

  def update
    flash[:notice] = 'Ticket Status was successfully updated.' if @ticket_status.update(ticket_status_params)
    respond_with(@ticket_status)
  end

  def destroy
    @ticket_status.destroy
    authorize @ticket_status
    respond_with(@ticket_status)
  end

  private
  
    def set_ticket_status
      @ticket_status = TicketStatus.find(params[:id])
      authorize @ticket_status
      @ticket_details = policy_scope(@ticket_status.tickets.inclusive) if @ticket_status.tickets
    end

    def ticket_status_params
      params.require(:ticket_status).permit(:name, :order, :time_tracked)
    end

    def calculate_time_taken
      @time_taken = TicketDetail.first.time_taken_all
    end
end
