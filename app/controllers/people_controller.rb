class PeopleController < ApplicationController

  before_filter :authenticate_user!
  after_action :verify_authorized

  before_action :set_person, only: [:show, :edit, :update, :destroy]

  # GET /people
  def index
    @people = polciy_scope(Person.inclusive)
    authorize @people
  end

  # GET /people/1
  def show
  end

  # GET /people/new
  def new
    @person = Person.new
    authorize @person
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  def create
    @person = Person.new(person_params)
    authorize @person
    if @person.save
      redirect_to @person, notice: 'Person was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /people/1
  def update
    if @person.update(person_params)
      redirect_to @person, notice: 'Person was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /people/1
  def destroy
    @person.destroy
    redirect_to people_url, notice: 'Person was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.inclusive.find(params[:id])
      authorize @person
      @ticket_details = policy_scope(@person.ticket_details) if @person.tickets_details
      @people = policy_scope(@person.employees) if @person.employees
    end

    # Only allow a trusted parameter "white list" through.
    def person_params
      params.require(:person).permit(:store_details_id, :startdate, :leavedate, :title, :firstname, :lastname, :preferredname, :jobtitle, :phone, :email)
    end
end
