class TicketSlasController < ApplicationController
  before_action :set_ticket_sla, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @ticket_slas = TicketSla.all
    respond_with(@ticket_slas)
  end

  def show
    respond_with(@ticket_sla)
  end

  def new
    @ticket_sla = TicketSla.new
    respond_with(@ticket_sla)
  end

  def edit
  end

  def create
    @ticket_sla = TicketSla.new(ticket_sla_params)
    flash[:notice] = 'TicketSla was successfully created.' if @ticket_sla.save
    respond_with(@ticket_sla)
  end

  def update
    flash[:notice] = 'TicketSla was successfully updated.' if @ticket_sla.update(ticket_sla_params)
    respond_with(@ticket_sla)
  end

  def destroy
    @ticket_sla.destroy
    respond_with(@ticket_sla)
  end

  private
    def set_ticket_sla
      @ticket_sla = TicketSla.find(params[:id])
    end

    def ticket_sla_params
      params.require(:ticket_sla).permit(:name, :order, :ticket_category_id, :ticket_priority, :time)
    end
end
