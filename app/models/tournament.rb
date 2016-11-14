class Tournament < ApplicationRecord
  belongs_to :host
  belongs_to :golf_course
  has_many :scheduled_events
  has_many :unscheduled_events
  has_many :teams
  has_many :photos
  has_many :sponsorships
  has_many :ticket_types
  mount_uploader :logoLink, PhotoUploader

  validates :name, presence: true
  validates :numGuests, presence: true
  validates :ticketsLeft, presence: true
  validates :registerStart, presence: true
  validates :registerEnd, presence: true

  before_validation(on: :create) do |t|
  	if self.ticketsLeft == nil or self.ticketsLeft == 0
  		self.ticketsLeft = self.numGuests
  	end
  end
end
