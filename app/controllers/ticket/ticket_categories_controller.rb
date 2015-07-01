class TicketCategoriesController < ApplicationController

  #load_and_authorize_resource 
  before_action :set_ticket_category, only: [:show, :edit, :update, :destroy]
  before_action :calculate_time_taken, only: [:index, :show, :edit]
  before_filter :set_lookups, only: [:edit, :update, :new]


  # GET /ticket/categories
  def index
    @ticket_categories = TicketCategory.inclusive
    authorize @ticket_categories
    @time_taken = TicketDetail.first.time_taken_all
  end

  # GET /ticket/categories/1
  def show
  end

  # GET /ticket/categories/new
  def new
    @ticket_category = TicketCategory.new
    authorize @ticket_category
  end

  # GET /ticket/categories/1/edit
  def edit
  end

  # POST /ticket/categories
  def create
    @ticket_category = TicketCategory.new(ticket_category_params)
    authorize @ticket_category
    if @ticket_category.save
      redirect_to @ticket_category, notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /ticket/categories/1
  def update
    if @ticket_category.update(ticket_category_params)
      redirect_to @ticket_category, notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /ticket/categories/1
  def destroy
    @ticket_category.destroy
    redirect_to ticket_categories_url, notice: 'Category was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket_category
      @ticket_category = TicketCategory.inclusive.find(params[:id])
      authorize @ticket_category
      @ticket_details = policy_scope(@ticket_category.tickets.inclusive) if @ticket_category.tickets #TicketDetail.where("ticket_category_id = ?", @ticket_category.id)
     
     # authorize @ticket_details
    end

    def set_lookups
      @parents = policy_scope(TicketCategory.all)

    end

    # Only allow a trusted parameter "white list" through.
    def ticket_category_params
      params.require(:ticket_category).permit(:name, :parent_id)
    end

    def calculate_time_taken
      @time_taken = TicketDetail.first.time_taken_all
    end
end
