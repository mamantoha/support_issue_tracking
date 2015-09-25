class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ticket, only: [:create, :new]

  # GET /comments/new
  def new
  end

  # POST /coments
  # POST /comment.json
  def create
    @comments = @ticket.comments
    @comment = @comments.create(comment_params)

    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @ticket, notice: 'Comment was successfully posted.' }
        format.json { render :show, status: :created, location: @comment }
      else
        # format.html { redirect_to @ticket }
        format.html { render 'tickets/show' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.friendly.find(params[:ticket_id])
    end


end
