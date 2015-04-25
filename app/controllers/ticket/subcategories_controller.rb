class Ticket::SubcategoriesController < ApplicationController
  before_action :set_ticket_subcategory, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @ticket_subcategories = Ticket::Subcategory.all
    respond_with(@ticket_subcategories)
  end

  def show
    respond_with(@ticket_subcategory)
  end

  def new
    @ticket_subcategory = Ticket::Subcategory.new
    respond_with(@ticket_subcategory)
  end

  def edit
  end

  def create
    @ticket_subcategory = Ticket::Subcategory.new(subcategory_params)
    @ticket_subcategory.save
    respond_with(@ticket_subcategory)
  end

  def update
    @ticket_subcategory.update(subcategory_params)
    respond_with(@ticket_subcategory)
  end

  def destroy
    @ticket_subcategory.destroy
    respond_with(@ticket_subcategory)
  end

  private
    def set_ticket_subcategory
      @ticket_subcategory = Ticket::Subcategory.find(params[:id])
    end

    def ticket_subcategory_params
      params.require(:ticket_subcategory).permit(:ticket_category_id, :name)
    end
end
