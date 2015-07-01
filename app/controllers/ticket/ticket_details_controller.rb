class TicketDetailsController < ApplicationController

  #load_and_authorize_resource :class => TicketDetail

  before_filter :authenticate_user!
  after_action :verify_authorized

 
  before_action :set_ticket_detail, only: [:show, :edit, :update, :destroy]
  before_filter :set_lookups, only: [:edit, :update, :new]


  # GET /ticket/details
  def index
    @ticket_details = policy_scope(TicketDetail.inclusive)
    authorize @ticket_details
    @time_taken = TicketDetail.first.time_taken_all

  end

  # GET /ticket/details/1
  def show
    
  end

  # GET /ticket/details/new
  def new
    @ticket_detail = TicketDetail.new(:name => params[:name], 
                                        :location_id => params[:location_id], 
                                        :ticket_category_id => params[:ticket_category_id],
                                        :ticket_status_id => params[:ticket_status_id]

                                        )
    authorize @ticket_detail
  end

  # GET /ticket/details/1/edit
  def edit
    
  end

  # POST /ticket/details
  def create
    @ticket_detail = TicketDetail.new(ticket_detail_params)
    authorize @ticket_detail
    @ticket_detail.created_by_id = 1


    if @ticket_detail.save
      redirect_to edit_ticket_detail_path(@ticket_detail), notice: 'Detail was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /ticket/details/1
  def update
    if @ticket_detail.update(ticket_detail_params)
      redirect_to edit_ticket_detail_path(@ticket_detail), notice: 'Detail was successfully updated.'
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
      @ticket_detail = TicketDetail.inclusive.find(params[:id])
      @ticket_comments = policy_scope(TicketComment.inclusive.where("ticket_detail_id = ?", @ticket_detail.id))

      authorize @ticket_detail
    end

    def set_lookups

      @locations = policy_scope(Location.inclusive)
      @categories = policy_scope(TicketCategory.all).arrange
      #sibling_ids = TicketCategory.find(yourcategories.arrange.first[0].id).sibling_ids
      #children_ids = TicketCategory.find(yourcategories.arrange.first[0].id).subtree_ids
      #@categories = TicketCategory.where("id IN (?) OR id IN (?)", sibling_ids, children_ids).arrange
      
      
     # @categories = nested_dropdown(@categories.arrange)
      @statuses = policy_scope(TicketStatus.where.not(:id => 1))
      
      @priorities = policy_scope(TicketPriority.all)
      @slas = TicketSla.all
      @types =   policy_scope(TicketType.all)
      @users = User.inclusive
      
      if @ticket_detail then
        @ticket_comments = policy_scope(TicketComment.inclusive.where("ticket_detail_id = ?", @ticket_detail.id))
        @ticket_status_histories = policy_scope(TicketStatusHistory.inclusive.where("ticket_detail_id = ?", @ticket_detail.id))
        @ticket_user_assignments = policy_scope(TicketUserAssignment.inclusive.where("ticket_detail_id = ?", @ticket_detail.id)) 
        @parents = policy_scope(TicketDetail.inclusive.where.not(id: @ticket_detail.id))
      end



      

    end

    # Only allow a trusted parameter "white list" through.
    def ticket_detail_params
      params.require(:ticket_detail).permit(:location_id, :parent_id, :ticket_type_id, :ticket_category_id, 
                                            :ticket_priority_id, :ticket_status_id,
                                            :comment_id, :name, :description, :created_by_id, :updated_by_id, 
                                            comments_attributes: [:ticket_detail_id, :name, :description, :type, 
                                                :created_by_id, :updated_by_id],
                                            ticket_user_assignments_attributes: [:ticket_detail_id, :user_id])
    end

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end

    def nested_dropdown(items)
      result = []
      items.map do |item, sub_items|
          result << [('- ' * item.depth) + item.name, item.id]
          result += nested_dropdown(sub_items) unless sub_items.blank?
      end
      result
  end
end
