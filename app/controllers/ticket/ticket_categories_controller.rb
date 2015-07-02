class TicketCategoriesController < ApplicationController

  before_filter :authenticate_user!
  after_action :verify_authorized
  
  before_action :set_ticket_category, only: [:show, :edit, :update, :destroy]
  before_filter :set_lookups, only: [:edit, :update, :new]
  
  before_action :calculate_time_taken, only: [:index, :show, :edit]

  def index
    @ticket_categories = TicketCategory.inclusive
    authorize @ticket_categories
  end
  
  def show
    p 'Showing'
  end

  def new
    @ticket_category = TicketCategory.new
    authorize @ticket_category
  end

  def edit
  end

  def create
    @ticket_category = TicketCategory.new(ticket_category_params)
    authorize @ticket_category
    flash[:notice] = 'Ticket Catgeory was successfully created.' if @ticket_category.save
    respond_with(@ticket_category)
  end

  def update
    uthorize @ticket_category
    flash[:notice] = 'Ticket Catgeory was successfully created.' if @ticket_category.save
    respond_with(@ticket_category)
  end

  def destroy
    @ticket_category.destroy
    redirect_to ticket_categories_url, notice: 'Ticket Category was successfully destroyed.'
  end

  private
    def set_ticket_category
      @ticket_category = TicketCategory.inclusive.find(params[:id])
      authorize @ticket_category
      @ticket_details = policy_scope(@ticket_category.ticket_details.inclusive.where("ticket_category_id IN (?)", @ticket_category.subtree_ids))#if @ticket_category.tickets
    end

    def set_lookups
      @parents = policy_scope(TicketCategory.where.not(ticket_category_id: @ticket_category.id))
    end

    def ticket_category_params
      params.require(:ticket_category).permit(:name, :parent_id)
    end

    def calculate_time_taken
      @time_taken = TicketDetail.first.time_taken_all
    end
end
