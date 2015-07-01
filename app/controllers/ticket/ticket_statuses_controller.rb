class TicketStatusesController < ApplicationController

  #load_and_authorize_resource 
  before_action :set_ticket_status, only: [:show, :edit, :update, :destroy]

  # GET /ticket/statuses
  def index
    @ticket_statuses = TicketStatus.inclusive
    authorize @ticket_statuses
  end

  # GET /ticket/statuses/1
  def show
     
  end

  # GET /ticket/statuses/new
  def new
    @ticket_status = TicketStatus.new
    authorize @ticket_status
  end

  # GET /ticket/statuses/1/edit
  def edit
  end

  # POST /ticket/statuses
  def create
    @ticket_status = TicketStatus.new(ticket_status_params)
    authorize @ticket_status
    if @ticket_status.save
      redirect_to @ticket_status, notice: 'Status was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /ticket/statuses/1
  def update
    if @ticket_status.update(ticket_status_params)
      redirect_to @ticket_status, notice: 'Status was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /ticket/statuses/1
  def destroy
    @ticket_status.destroy
    redirect_to ticket_statuses_url, notice: 'Status was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket_status
      @ticket_status = TicketStatus.find(params[:id])
      authorize @ticket_status
      @ticket_details = policy_scope(TicketDetail.where("ticket_status_id = ?", @ticket_status.id).inclusive)
      
    end

    # Only allow a trusted parameter "white list" through.
    def ticket_status_params
      params.require(:ticket_status).permit(:name, :order, :time_tracked)
    end
end
