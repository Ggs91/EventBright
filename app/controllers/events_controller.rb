class EventsController < ApplicationController
  include EventsHelper
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :ensure_current_user_is_administrator, only: [:edit, :update, :destroy]

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
      @event = Event.new(event_params.merge(administrator: current_user, start_date: parsed_date, duration: parsed_duration))

    if @event.save 
      flash[:success] = "Your event has been created !"
      redirect_to @event
    else
      flash.now[:warning] = "Your event has not been created"
      render :new
    end
  end

  def edit
    @event
  end

  def update
    if @event.update(event_params)
      flash[:success] = "Event successfully edited !"
      redirect_to @event
    else
      flash.now[:warning] = "Event couldn't be edited"
      render :edit
    end
  end

  def destroy
    @event.destroy
    flash[:success] = "Event successfully deleted"
    redirect_to root_path
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:title, :description, :location, :price)
  end  

  def ensure_current_user_is_administrator
    current_user_is_administrator?(@event)
  end

	def parsed_date
		date = params.require(:event).permit(:start_date) 
	  DateTime.parse("#{date}")
	end    

  def parsed_duration
		hours = params.require(:event).permit("duration(4i)")["duration(4i)"]
    minutes = params.require(:event).permit("duration(5i)")["duration(5i)"]
	  minutes.to_i + hours.to_i * 60 
	end    
end
