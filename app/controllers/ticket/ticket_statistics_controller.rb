class TicketStatisticsController < ApplicationController

  before_filter :authenticate_user!
  after_action :verify_authorized
  before_action :set_ticket_statistic, only: [:show, :edit, :update, :destroy]

  # GET /ticket/statistics
  def index
    @ticket_statistics = policy_scope(TicketStatistic.inclusive)
    authorize @ticket_statistics
    @tickets_open = @ticket_statistics.sum(:open)
    @tickets_closed = @ticket_statistics.sum(:closed)
    @tickets_critical = @ticket_statistics.sum(:critical)
    @tickets_high = @ticket_statistics.sum(:high)
    @tickets_new = @ticket_statistics.sum(:new)

  end

  # GET /ticket/statistics/1
  def show
  end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket_statistic
      @ticket_statistic = TicketStatistic.inclusive.find(params[:id])
      authorize @ticket_statistic
    end

   
end
