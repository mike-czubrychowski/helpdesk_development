class Ticket::UsersController < ApplicationController
  before_action :set_ticket_user, only: [:show, :edit, :update, :destroy]

  # GET /ticket/users
  def index
    @ticket_users = Ticket::User.all
  end

  # GET /ticket/users/1
  def show
  end

  # GET /ticket/users/new
  def new
    @ticket_user = Ticket::User.new
  end

  # GET /ticket/users/1/edit
  def edit
  end

  # POST /ticket/users
  def create
    @ticket_user = Ticket::User.new(ticket_user_params)

    if @ticket_user.save
      redirect_to @ticket_user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /ticket/users/1
  def update
    if @ticket_user.update(ticket_user_params)
      redirect_to @ticket_user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /ticket/users/1
  def destroy
    @ticket_user.destroy
    redirect_to ticket_users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket_user
      @ticket_user = Ticket::User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ticket_user_params
      params.require(:ticket_user).permit(:detail_id, :user_id)
    end
end
