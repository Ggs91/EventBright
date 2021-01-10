class EventsController < ApplicationController
  include EventsHelper
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :ensure_current_user_is_administrator, only: [:edit, :update, :destroy]
  before_action :amount_to_be_charged, only: [:show]
  
  def index
    @pagy, @events = pagy(Event.all.with_attached_images.order("created_at DESC"), items: 9)
  end
  
  def show
    @event
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params.merge(administrator: current_user, start_date: parsed_datetime, duration: parsed_duration, price: formated_price))
    
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
    params.require(:event).permit(:title, :description, :location, :price, images: [])
  end  

  def ensure_current_user_is_administrator
    current_user_is_administrator?(@event)
  end

	def parsed_datetime
    date = params.require(:event).permit(:starting_date)[:starting_date]
    time = params.require(:event).permit(:starting_time)[:starting_time]
	  DateTime.parse("#{date} #{time}")
	end    

  def parsed_duration
		hours = params.require(:event).permit("duration(4i)")["duration(4i)"]
    minutes = params.require(:event).permit("duration(5i)")["duration(5i)"]
	  minutes.to_i + hours.to_i * 60 
  end    

  def formated_price
    price = params.require(:event).permit(:price)[:price]
    price.to_i * 100
  end

  def amount_to_be_charged
    # Amount in cents
    @amount = @event.price
  end
end