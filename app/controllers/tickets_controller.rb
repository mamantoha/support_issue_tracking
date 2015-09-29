class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy, :assign_to_me]
  before_action :authenticate_user!, except: [:show, :new, :create]

  # GET /tickets
  # GET /tickets.json
  def index
    if params[:q].nil?
      @tickets = Ticket.all
    else
      @tickets = Ticket.search(params[:q]).records
    end

    authorize(@tickets)

    @tickets = case params[:status]
    when 'unassigned'
      @tickets.unassigned
    when 'opened'
      @tickets.opened
    when 'on_holded'
      @tickets.on_holded
    when 'closed'
      @tickets.completed
    else
      params[:status] = 'unassigned'
      @tickets.unassigned
    end

    @tickets = @tickets.paginate per_page: 2, page: params[:page]
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
    @users = User.all
    @comment = Comment.new
    @comments = @ticket.comments.paginate per_page: 2, page: params[:page]
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
    authorize(@ticket)
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)
    authorize(@ticket)

    respond_to do |format|
      if @ticket.save
        TicketMailer.new_ticket(@ticket).deliver_later

        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    authorize(@ticket)
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def assign_to_me
    authorize(@ticket)
    @ticket.assignee = @current_user

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :show }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:name, :subject, :body, :email, :assignee_id, :status, :department_id)
    end
end
