class Ticket::CategoriesController < ApplicationController
  before_action :set_ticket_category, only: [:show, :edit, :update, :destroy]

  # GET /ticket/categories
  def index
    @ticket_categories = Ticket::Category.all
  end

  # GET /ticket/categories/1
  def show
  end

  # GET /ticket/categories/new
  def new
    @ticket_category = Ticket::Category.new
  end

  # GET /ticket/categories/1/edit
  def edit
  end

  # POST /ticket/categories
  def create
    @ticket_category = Ticket::Category.new(ticket_category_params)

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
      @ticket_category = Ticket::Category.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ticket_category_params
      params.require(:ticket_category).permit(:name)
    end
end
