class LocationsController < ApplicationController
  
  before_filter :authenticate_user!
  after_action :verify_authorized

  before_action :set_location, only: [:show, :edit, :update, :destroy]
  before_action :set_location_category #STI

  before_action :calculate_time_taken, only: [:index, :show, :edit]
  
  # GET /locations
  def index
    #Required for STI
    @locations = policy_scope(location_category.constantize.inclusive)
    authorize @locations#where("id IN (?)", current_user.location.subtree_ids)
  end

  # GET /locations/1
  def show
  end

  # GET /locations/new
  def new
    @location = Location.new
    authorize @location
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  def create
    @location = Location.new(location_params)
    authorize @location

    if @location.save
      redirect_to @location, notice: 'Location was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /locations/1
  def update
    if @location.update(location_params)
      redirect_to @location, notice: 'Location was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /locations/1
  def destroy
    @location.destroy
    redirect_to locations_url, notice: 'Location was successfully destroyed.'
  end
  
  private
    def set_location
      @location = Location.inclusive.find(params[:id])#.where("id IN (?)", current_user.location.subtree_ids)
      authorize @location
      @ticket_details = policy_scope(@location.tickets) if @location.tickets
      @people = policy_scope(@location.employees) if @location.employees

      
    end

    def set_location_category
     @location_category = location_category
    end

    def location_category
      Location.categories.include?(params[:type]) ? params[:type] : "Location"
    end

    # Only allow a trusted parameter "white list" through.
    def location_params
      params.require(:location).permit(:name, :parent_id, :category, :manager_id)
    end

    def calculate_time_taken
      @time_taken = TicketDetail.first.time_taken_all
    end
end
