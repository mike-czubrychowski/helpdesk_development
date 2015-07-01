class TicketStatusHistoriesController < ApplicationController

  #load_and_authorize_resource 
  before_action :set_ticket_status_history, only: [:show, :edit, :update, :destroy]

  # GET /ticket/status_histories
  def index
    @ticket_status_histories = TicketStatusHistory.inclusive
    authorize @ticket_status_histories
  end

  # GET /ticket/status_histories/1
  def show
  end

  # GET /ticket/status_histories/new
  def new
    @ticket_status_history = TicketStatusHistory.new
    authorize @ticket_status_history
  end

  # GET /ticket/status_histories/1/edit
  def edit
  end

  # POST /ticket/status_histories
  def create
    @ticket_status_history = TicketStatusHistory.new(ticket_status_history_params)
    authorize @ticket_status_history
    if @ticket_status_history.save
      redirect_to @ticket_status_history, notice: 'Status history was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /ticket/status_histories/1
  def update
    if @ticket_status_history.update(ticket_status_history_params)
      redirect_to @ticket_status_history, notice: 'Status history was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /ticket/status_histories/1
  def destroy
    @ticket_status_history.destroy
    redirect_to ticket_status_histories_url, notice: 'Status history was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket_status_history
      @ticket_status_history = TicketStatusHistory.inclusive.find(params[:id])
      authorize @ticket_status_history
    end

    # Only allow a trusted parameter "white list" through.
    def ticket_status_history_params
      params.require(:ticket_status_history).permit(:detail_id, :status_id, :from, :to, :updated_by_id)
    end
end
