class TicketSlasController < ApplicationController
  
  before_filter :authenticate_user!
  after_action :verify_authorized
  before_action :set_ticket_sla, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @ticket_slas = policy_scope(TicketSla.all)
    authorize @ticket_slas
  end

  def show
  end

  def new
    @ticket_sla = TicketSla.new
    authorize @ticket_sla
  end

  def edit
  end

  def create
    @ticket_sla = TicketSla.new(ticket_sla_params)
    authorize @ticket_sla
    flash[:notice] = 'TicketSla was successfully created.' if @ticket_sla.save
    respond_with(@ticket_sla)
  end

  def update
    flash[:notice] = 'TicketSla was successfully updated.' if @ticket_sla.update(ticket_sla_params)
    respond_with(@ticket_sla)
  end

  def destroy
    @ticket_sla.destroy
    authorize @ticket_sla
    respond_with(@ticket_sla)
  end

  private
    def set_ticket_sla
      @ticket_sla = TicketSla.find(params[:id])
      authorize @ticket_sla
    end

    def ticket_sla_params
      params.require(:ticket_sla).permit(:name, :order, :ticket_category_id, :ticket_priority, :breach, :warn)
    end
end
