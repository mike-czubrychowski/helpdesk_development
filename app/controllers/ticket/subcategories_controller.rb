class Ticket::SubcategoriesController < ApplicationController

  load_and_authorize_resource 
  before_action :set_ticket_subcategory, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @ticket_subcategories = Ticket::Subcategory.all
  end

  def show
  end

  def new
    @ticket_subcategory = Ticket::Subcategory.new
  end

  def edit
  end

  def create
    @ticket_subcategory = Ticket::Subcategory.new(subcategory_params)

    if @ticket_subcategory.save
      redirect_to @ticket_subcategory, notice: 'Subcategory was successfully created.'
    else
      render :new
    end
    
  end

  def update

    if @ticket_subcategory.update(subcategory_params)
      redirect_to @ticket_subcategory, notice: 'Subcategory was successfully updated.'
    else
      render :edit
    end
  
  end

  def destroy
    @ticket_subcategory.destroy
    respond_with(@ticket_subcategory)
  end

  private
    def set_ticket_subcategory
      @ticket_subcategory = Ticket::Subcategory.find(params[:id])
      @ticket_details = @ticket_subcategory.tickets
    end

    def ticket_subcategory_params
      params.require(:ticket_subcategory).permit(:ticket_category_id, :name)
    end
end
