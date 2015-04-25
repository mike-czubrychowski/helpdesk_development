class Ticket::DetailsController < ApplicationController
  before_action :set_ticket_detail, only: [:show, :edit, :update, :destroy]
  before_filter :set_lookups, only: [:edit, :update, :new]


  # GET /ticket/details
  def index
    @ticket_details = Ticket::Detail.all
  end

  # GET /ticket/details/1
  def show
    @ticket_comments = Ticket::Comment.where("ticket_detail_id = ?", @ticket_detail.id)
  end

  # GET /ticket/details/new
  def new
    @ticket_detail = Ticket::Detail.new(:name => params[:name], :location_id => params[:location_id]) 
  end

  # GET /ticket/details/1/edit
  def edit
     @ticket_comments = Ticket::Comment.where("ticket_detail_id = ?", @ticket_detail.id)
  end

  # POST /ticket/details
  def create
    @ticket_detail = Ticket::Detail.new(ticket_detail_params)
    @ticket_detail.created_by_id = 1


    if @ticket_detail.save
      redirect_to @ticket_detail, notice: 'Detail was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /ticket/details/1
  def update
    if @ticket_detail.update(ticket_detail_params)
      redirect_to @ticket_detail, notice: 'Detail was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /ticket/details/1
  def destroy
    @ticket_detail.destroy
    redirect_to ticket_details_url, notice: 'Detail was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket_detail
      @ticket_detail = Ticket::Detail.find(params[:id])
    end

    def set_lookups

      @locations = Location.all
      @categories = Ticket::Category.all
      @subcategories = Ticket::Subcategory.all
      @statuses = Ticket::Status.all
      @parents = Ticket::Detail.all
      @priorities = Ticket::Detail.ticket_priorities.map {|k, v| [k.humanize.capitalize, k]}
      @types =   Ticket::Detail.ticket_types.map {|k, v| [k.humanize.capitalize, k]}

    end

    # Only allow a trusted parameter "white list" through.
    def ticket_detail_params
      params.require(:ticket_detail).permit(:location_id, :parent_id, :ticket_type, :category_id, :subcategory_id, :ticket_priority, :status_id, :comment_id, :name, :description, :created_by_id, :updated_by_id)
    end
end
