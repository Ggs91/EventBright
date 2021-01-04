class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable #, :omniauthable
  # Associations 
  has_many :participations, dependent: :destroy
  has_many :attended_events, through: :participations, source: :event, dependent: :destroy
  has_many :administrated_events, foreign_key: "administrator_id", class_name: "Event", dependent: :destroy
  # Validations
  validates :username,
    uniqueness: true
  validates :first_name, :last_name,
    presence: true,
    on: :update
  validates :description,
    presence: true,
    length: { minimum: 5 },
    on: :update
  # Callbacks
  after_create :welcome_send

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
end
