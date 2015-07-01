class StoreTillsController < ApplicationController
  before_action :set_store_till, only: [:show, :edit, :update, :destroy]

  # GET /store/tills
  def index
    @store_tills = StoreTill.all
  end

  # GET /store/tills/1
  def show
  end

  # GET /store/tills/new
  def new
    @store_till = StoreTill.new
  end

  # GET /store/tills/1/edit
  def edit
  end

  # POST /store/tills
  def create
    @store_till = StoreTill.new(store_till_params)

    if @store_till.save
      redirect_to @store_till, notice: 'Till was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /store/tills/1
  def update
    if @store_till.update(store_till_params)
      redirect_to @store_till, notice: 'Till was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /store/tills/1
  def destroy
    @store_till.destroy
    redirect_to store_tills_url, notice: 'Till was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store_till
      @store_till = StoreTill.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def store_till_params
      params.require(:store_till).permit(:name, :location_id, :model, :ip, :comms_support, :mid, :ped_user, :ped_pin, :pos_keyboard)
    end
end
