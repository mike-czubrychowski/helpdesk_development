class LocationsController < ApplicationController
  before_action :set_category
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  # GET /locations
  def index
    @locations = @locations = klass.all
  end

  # GET /locations/1
  def show
    #why doesn't this work with scopes?
    @ticket_details = Ticket::Detail.where("location_id in (?)", @location.subtree_ids)
    #@people = @location.manager.sublocations.people

    
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
      @location = Location.find(params[:id])
    end

    def set_category
     @category = category
    end

    def category
      Location.categories.include?(params[:type]) ? params[:type] : "Location"
    end

    def klass
      category.constantize 
    end


    # Only allow a trusted parameter "white list" through.
    def location_params
      params.require(:location).permit(:name, :parent_id, :category, :manager_id)
    end
end
