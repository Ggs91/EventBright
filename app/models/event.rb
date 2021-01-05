class Event < ApplicationRecord
  # virtual attributes to retrieve date and time in 2 different fields
  attr_accessor :starting_date, :starting_time

  # Associations
  belongs_to :administrator, class_name: "User"
  has_many :participations, dependent: :destroy
  has_many :participants, through: :participations, source: :user, dependent: :destroy
  # Validations
  validate :start_date_cannot_be_in_the_past
  validate :duration_must_be_positif_multiple_of_5
  validates_numericality_of :price,
    greater_than_or_equal_to:  0,
    less_than: 100000,
    only_integer: true,
    message: 'Price must be between 0 and 1000' 
  validates :duration, numericality: { only_integer: true }
  validates :title, presence: true, length: { in: 5..140 }
  validates :description, presence: true, length: { in: 5..1000 }
  validates :location, presence: true

  def start_date_cannot_be_in_the_past
    errors.add(:start_date, "time and date must be present or can't be in the past") unless start_date.present? && DateTime.parse("#{start_date}") >= DateTime.now.change(offset: "+0000")
  end

  def duration_must_be_positif_multiple_of_5
    errors.add(:duration, "must be a multiple of 5") unless duration.present? && duration > 0 && duration % 5 == 0
  end

  def starting_date
    self.start_date.strftime("%Y-%m-%d at %H:%M")
  end

  def ending_date
    end_date = self.start_date + self.duration.minutes
    end_date.strftime("%Y-%m-%d at %H:%M")
  end

  def is_free?
    self.price == 0
  end
end
