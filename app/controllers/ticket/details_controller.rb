class Ticket::DetailsController < ApplicationController

  #load_and_authorize_resource :class => Ticket::Detail

  before_filter :authenticate_user!
  after_action :verify_authorized

  #include Concerns::PunditNamespaces

  #def pundit_namespace
  #  Ticket
  #end


  # def self.policy_class
  #   TicketDetailPolicy
  # end


  before_action :set_ticket_detail, only: [:show, :edit, :update, :destroy]
  before_filter :set_lookups, only: [:edit, :update, :new]


  # GET /ticket/details
  def index
    @ticket_details = policy_scope(Ticket::Detail.inclusive)
    #authorize! :index, @ticket_details
    authorize @ticket_details
    #
  end

  # GET /ticket/details/1
  def show
    
  end

  # GET /ticket/details/new
  def new
    @ticket_detail = Ticket::Detail.new(:name => params[:name], 
                                        :location_id => params[:location_id], 
                                        :ticket_category_id => params[:ticket_category_id],
                                        :ticket_subcategory_id => params[:ticket_subcategory_id],
                                        :ticket_status_id => params[:ticket_status_id]

                                        ) 
  end

  # GET /ticket/details/1/edit
  def edit
    
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
      @ticket_detail = Ticket::Detail.find(params[:id])
      @ticket_comments = Ticket::Comment.where("ticket_detail_id = ?", @ticket_detail.id)

      authorize @ticket_detail
    end

    def set_lookups

      @locations = Location.all
      @categories = Ticket::Category.all
      @subcategories = Ticket::Subcategory.all
      @statuses = Ticket::Status.all
      @parents = Ticket::Detail.all
      @priorities = Ticket::Detail.ticket_priorities.map {|k, v| [k.humanize.capitalize, k]}
      @types =   Ticket::Detail.ticket_types.map {|k, v| [k.humanize.capitalize, k]}
      @users = User.all
      
      if @ticket_detail then
        @ticket_comments = Ticket::Comment.where("ticket_detail_id = ?", @ticket_detail.id)
        @ticket_status_histories = Ticket::StatusHistory.where("ticket_detail_id = ?", @ticket_detail.id)
        @ticket_user_assignments = Ticket::UserAssignment.where("ticket_detail_id = ?", @ticket_detail.id)
      end



      

    end

    # Only allow a trusted parameter "white list" through.
    def ticket_detail_params
      params.require(:ticket_detail).permit(:location_id, :parent_id, :ticket_type, :ticket_category_id, 
                                            :ticket_subcategory_id, :ticket_priority, :ticket_status_id,
                                            :comment_id, :name, :description, :created_by_id, :updated_by_id, 
                                            comments_attributes: [:ticket_detail_id, :name, :description, :type, 
                                                :created_by_id, :updated_by_id],
                                            ticket_user_assignments_attributes: [:ticket_detail_id, :user_id])
    end

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end
end
