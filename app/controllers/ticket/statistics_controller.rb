class Ticket::StatisticsController < ApplicationController
  before_action :set_ticket_statistic, only: [:show, :edit, :update, :destroy]

  # GET /ticket/statistics
  def index
    @ticket_statistics = Ticket::Statistic.all
  end

  # GET /ticket/statistics/1
  def show
  end

  # GET /ticket/statistics/new
  def new
    @ticket_statistic = Ticket::Statistic.new
  end

  # GET /ticket/statistics/1/edit
  def edit
  end

  # POST /ticket/statistics
  def create
    @ticket_statistic = Ticket::Statistic.new(ticket_statistic_params)

    if @ticket_statistic.save
      redirect_to @ticket_statistic, notice: 'Statistic was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /ticket/statistics/1
  def update
    if @ticket_statistic.update(ticket_statistic_params)
      redirect_to @ticket_statistic, notice: 'Statistic was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /ticket/statistics/1
  def destroy
    @ticket_statistic.destroy
    redirect_to ticket_statistics_url, notice: 'Statistic was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket_statistic
      @ticket_statistic = Ticket::Statistic.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ticket_statistic_params
      params.require(:ticket_statistic).permit(:location_id)
    end
end
