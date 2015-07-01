class TicketPrioritiesController < ApplicationController
  before_action :set_ticket_priority, only: [:show, :edit, :update, :destroy]
  before_action :calculate_time_taken, only: [:index, :show, :edit]

  respond_to :html

  def index
    @ticket_priorities = TicketPriority.inclusive
    authorize @ticket_priorities
  end

  def show
    
  end

  def new
    @ticket_priority = TicketPriority.new
    authorize @ticket_priority
  end

  def edit
  end

  def create
    @ticket_priority = TicketPriority.new(ticket_priority_params)
    authorize @ticket_priority
    flash[:notice] = 'TicketPriority was successfully created.' if @ticket_priority.save
    respond_with(@ticket_priority)
  end

  def update
    flash[:notice] = 'TicketPriority was successfully updated.' if @ticket_priority.update(ticket_priority_params)
    respond_with(@ticket_priority)
  end

  def destroy
    @ticket_priority.destroy
    authorize @ticket_priority
    respond_with(@ticket_priority)
  end

  private
    def set_ticket_priority
      @ticket_priority = TicketPriority.inclusive.find(params[:id])
      authorize @ticket_priority
      @ticket_details = @ticket_priority.tickets.inclusive if @ticket_priority.tickets
    end

    def ticket_priority_params
      params.require(:ticket_priority).permit(:name, :order)
    end

    def calculate_time_taken
      @time_taken = TicketDetail.first.time_taken_all
    end
end
