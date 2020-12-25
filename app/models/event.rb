class Event < ApplicationRecord
  # Associations
  belongs_to :administrator
  has_many :participations, dependent: :destroy
  has_many :participants, through: :participations, source: :user, dependent: :destroy

end
