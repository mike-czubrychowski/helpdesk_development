class LocationsController < ApplicationController
  
  #load_and_authorize_resource :location, :ticket_detail, :person

  before_action :set_location_category
  before_action :set_location, only: [:show, :edit, :update, :destroy]
 
  # GET /locations
  def index
    #Required for STI
    @locations = location_category.constantize.inclusive
  end

  # GET /locations/1
  def show
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  def create
    @location = Location.new(location_params)

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
      @location = Location.inclusive.find(params[:id])
      @ticket_details = @location.tickets
      @people = @location.employees
      
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
end
