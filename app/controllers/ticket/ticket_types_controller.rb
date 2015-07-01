class TicketTypesController < ApplicationController
  before_action :set_ticket_type, only: [:show, :edit, :update, :destroy]
  before_action :calculate_time_taken, only: [:index, :show, :edit]


  respond_to :html

  def index
    @ticket_types = TicketType.inclusive
    authorize @ticket_types 
  end

  def show
    
  end

  def new
    @ticket_type = TicketType.new
    authorize @ticket_type
  end

  def edit
  end

  def create
    @ticket_type = TicketType.new(ticket_type_params)
    authorize @ticket_type
    flash[:notice] = 'TicketType was successfully created.' if @ticket_type.save
    respond_with(@ticket_type)
  end

  def update
    flash[:notice] = 'TicketType was successfully updated.' if @ticket_type.update(ticket_type_params)
    respond_with(@ticket_type)
  end

  def destroy
    @ticket_type.destroy
    respond_with(@ticket_type)
  end

  private
    def set_ticket_type
      @ticket_type = TicketType.inclusive.find(params[:id])
      authorize @ticket_type
      @ticket_details = @ticket_type.tickets.inclusive if @ticket_type.tickets
    end

    def ticket_type_params
      params.require(:ticket_type).permit(:name, :order)
    end

    def calculate_time_taken
      @time_taken = TicketDetail.first.time_taken_all
    end
end
