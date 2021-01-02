module EventsHelper
  def current_user_already_participant?(event)
    event.participants.include?(current_user)
  end
  def current_user_is_administrator?(event)
    event.administrator == current_user
  end
end