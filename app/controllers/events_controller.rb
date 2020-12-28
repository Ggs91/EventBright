class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @events = Event.all.order("created_at DESC")
  end
  
  def show
    @event
  end

  def new
    @event = Event.new
  end

  def create
      @event = Event.new(event_params.merge(administrator: current_user))

    if @event.save 
      flash[:success] = "Your event has been created !"
      redirect_to :show
    else
      flash[:warning] = "Your event has not been created"
      render :new
    end
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:title, :description,:start_date, :location, :price, :duration)
  end  
end
