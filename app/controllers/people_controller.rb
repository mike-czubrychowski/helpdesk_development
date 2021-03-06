class PeopleController < ApplicationController

  #load_and_authorize_resource 
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  # GET /people
  def index
    @people = Person.inclusive.accessible_by(current_ability)
  end

  # GET /people/1
  def show
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  def create
    @person = Person.new(person_params)

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
      @person = Person.find(params[:id])
      @ticket_details = @person.tickets
      @people = @person.employees
    end

    # Only allow a trusted parameter "white list" through.
    def person_params
      params.require(:person).permit(:store_details_id, :startdate, :leavedate, :title, :firstname, :lastname, :preferredname, :jobtitle, :phone, :email)
    end
end
