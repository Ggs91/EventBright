class ParticipationsController < ApplicationController
  include EventsHelper
    before_action :authenticate_user!
    before_action :set_event, only: [:index, :new, :create]
    before_action :amount_to_be_charged, only: [:new, :create]
    before_action :ensure_current_user_is_not_already_particitpant, only: [:new, :create]
    before_action :ensure_current_user_is_administrator, only: [:index]
    before_action :set_participation, only: [:destroy]

  def index
    @event
  end

  # ensure_current_user_is_not_already_particitpant run before new & create and return (and so cancel them) if user is already participants 
  # https://guides.rubyonrails.org/action_controller_overview.html#filters
  def new
    @participation = Participation.new
  end

  def create
    #Best practice for stripe integration
    # https://rails.devcamp.com/trails/ruby-gem-walkthroughs/campsites/payment/guides/how-to-integrate-stripe-payments-in-a-rails-application-charges

    customer = StripeTool.create_customer(
                 email: params[:stripeEmail],
                 stripe_token: params[:stripeToken],
               )

    charge = StripeTool.create_charge(
               customer_id: customer.id,
               amount: @amount,
               description: 'Rails Stripe Customer',
               currency: 'eur',
             )

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

  def ensure_current_user_is_administrator
    current_user_is_administrator?(@event)
  end

  def amount_to_be_charged
    # Amount in cents
    @amount = @event.price
  end


  def ensure_current_user_is_not_already_particitpant #Dans la view le btn pour participer à un event change à "cancel" si current user est deja inscrit donc théroiquement pas possible de se ré-inscrir mais au cas ou 
    if current_user_already_participant?(@event)
      flash[:warning] = "You're already part of this event"
      redirect_to @event
    end
  end
end