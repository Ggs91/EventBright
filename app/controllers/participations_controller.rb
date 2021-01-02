class ParticipationsController < ApplicationController
  include EventsHelper
    before_action :authenticate_user!
    before_action :set_event, only: [:new, :create]
    before_action :ensure_current_user_is_not_already_particitpant, only: [:new, :create]
    before_action :set_participation, only: [:destroy]
    # before_action :check_administrator, only: [:index]

  def index

  end

  # ensure_current_user_is_not_already_particitpant run before new & create and return (and so cancel them) if user is already participants 
  # https://guides.rubyonrails.org/action_controller_overview.html#filters
  def new
    @participation = Participation.new
  end

  def create
    # Amount in cents
    @amount = @event.price

    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      currency: 'eur',
    })

    Participation.create(user: current_user, event: @event)
    flash[:success] = "Your are part of this event !"
    redirect_to @event

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to @event
  end
  
  def destroy
    @participation.destroy
    flash[:info] = "You are no longer part of this event"
    redirect_back(fallback_location: root_path)
  end
  
private

  def set_participation
    @participation = Participation.where(user: current_user, event: params[:event_id]).first
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def check_administrator

  end

  def ensure_current_user_is_not_already_particitpant #Dans la view le btn pour participer à un event change à "cancel" si current user est deja inscrit donc théroiquement pas possible de se ré-inscrir mais au cas ou 
    if current_user_already_participant?(@event)
      flash[:warning] = "You're already part of this event"
      redirect_to @event
    end
  end
end