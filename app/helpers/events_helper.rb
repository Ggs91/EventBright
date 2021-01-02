module EventsHelper
  def current_user_already_participant?(event)
    event.participants.include?(current_user)
  end
end