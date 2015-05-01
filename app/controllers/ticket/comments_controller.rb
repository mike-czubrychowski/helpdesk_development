class Ticket::CommentsController < ApplicationController

  load_and_authorize_resource 
  before_action :set_ticket_comment, only: [:show, :edit, :update, :destroy]
  before_filter :set_lookups, only: [:edit, :update, :new]


  # GET /ticket/comments
  def index
    @ticket_comments = Ticket::Comment.all
  end

  # GET /ticket/comments/1
  def show
  end

  # GET /ticket/comments/new
  def new
    @ticket_comment = Ticket::Comment.new(:ticket_detail_id => params[:ticket_detail_id])
  end

  # GET /ticket/comments/1/edit
  def edit
  end

  # POST /ticket/comments
  def create
    @ticket_comment = Ticket::Comment.new(ticket_comment_params)

    if @ticket_comment.save
      redirect_to @ticket_comment, notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /ticket/comments/1
  def update
    if @ticket_comment.update(ticket_comment_params)
      redirect_to @ticket_comment, notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /ticket/comments/1
  def destroy
    @ticket_comment.destroy
    redirect_to ticket_comments_url, notice: 'Comment was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket_comment
      @ticket_comment = Ticket::Comment.find(params[:id])
      @ticket_detail = Ticket::Detail.find(@ticket_comment.ticket_detail_id)
    end

    def set_lookups

      @comment_types =   Ticket::Comment.comment_types.map {|k, v| [k.humanize.capitalize, k]}

    end

    # Only allow a trusted parameter "white list" through.
    def ticket_comment_params
      params.require(:ticket_comment).permit(:ticket_detail_id, :name, :description, :type, :created_by_id, :updated_by_id)
    end
end
