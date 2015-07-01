class OrganisationsController < ApplicationController

  #load_and_authorize_resource 
  before_action :set_organisation, only: [:show, :edit, :update, :destroy]

  # GET /organisations
  def index
    @organisations = Organisation.all
    authorize @organisations
  end

  # GET /organisations/1
  def show
  end

  # GET /organisations/new
  def new
    @organisation = Organisation.new
    authorize @organisation
  end

  # GET /organisations/1/edit
  def edit
  end

  # POST /organisations
  def create
    @organisation = Organisation.new(organisation_params)
    authorize @organisation
    if @organisation.save
      redirect_to @organisation, notice: 'Organisation was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /organisations/1
  def update
    if @organisation.update(organisation_params)
      redirect_to @organisation, notice: 'Organisation was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /organisations/1
  def destroy
    @organisation.destroy
    redirect_to organisations_url, notice: 'Organisation was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organisation
      @organisation = Organisation.find(params[:id])
      authorize @organisation
      @ticket_details = policy_scope(@organisation.tickets) if @organisation.tickets
      @users = policy_scope(@organisation.users) if @organisation.users
    end

    # Only allow a trusted parameter "white list" through.
    def organisation_params
      params.require(:organisation).permit(:name)
    end
end
