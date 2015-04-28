class Store::DetailsController < ApplicationController
  before_action :set_store_detail, only: [:show, :edit, :update, :destroy]

  # GET /store/details
  def index
    @store_details = Store::Detail.inclusive
  end

  # GET /store/details/1
  def show
  end

  # GET /store/details/new
  def new
    @store_detail = Store::Detail.new
  end

  # GET /store/details/1/edit
  def edit
  end

  # POST /store/details
  def create
    @store_detail = Store::Detail.new(store_detail_params)

    if @store_detail.save
      redirect_to @store_detail, notice: 'Detail was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /store/details/1
  def update
    if @store_detail.update(store_detail_params)
      redirect_to @store_detail, notice: 'Detail was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /store/details/1
  def destroy
    @store_detail.destroy
    redirect_to store_details_url, notice: 'Detail was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store_detail
      @store_detail = Store::Detail.inclusive.find(params[:id])
      @ticket_details = @store_detail.tickets
      @people = @store_detail.employees
    end

    # Only allow a trusted parameter "white list" through.
    def store_detail_params
      params.require(:store_detail).permit(:name, :location_id, :account, :status, :openingday, :address1, :address2, :address3, :town, :county, :postcode, :phone, :uk_country, :centreofexcellence, :superleague, :latitude, :longitude)
    end
end
