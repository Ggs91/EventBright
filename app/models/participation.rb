class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :event
    # Callbacks
  after_create :participation_email

  def participation_email
    ParticipationMailer.event_participation_email(self).deliver_now
  end
end
