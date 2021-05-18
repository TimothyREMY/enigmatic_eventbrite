class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]
  before_action :authenticate_user, only: [:new, :show, :edit]

  # GET /events or /events.json
  def index
    @events = Event.all
  end

  # GET /events/1 or /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)

    
    @event.admin = current_user

    
      if @event.save 
        flash[:notice] = 'The event were successfully created'
        redirect_to event_path(@event.id)
      else
        flash[:notice] = 'The event can not be created, it is not completed'
        render :new
      end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
   
      if @event.update(event_params) && @event.admin == current_user
        flash[:notice] = 'The event were successfully updated'
        redirect_to events_url
      else
        flash[:notice] = 'The event can not be updated, you are not the author of this event'
        redirect_to event_path(params[:id])
      end
    
      
    
    
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:start_date, :duration, :description, :title, :price, :location, :admin_id)
    end

    def authenticate_user
      unless current_user
        flash[:danger] = "Please log in."
        redirect_to new_session_path
      end
    end
end
