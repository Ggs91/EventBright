module ParticipationsHelper
  def current_user_participation(event)
    Participation.where(user:current_user, event:event).first
  end
end