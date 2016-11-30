class Tournament < ApplicationRecord
  belongs_to :host
  belongs_to :golf_course
  has_many :scheduled_events
  has_many :unscheduled_events
  has_many :teams
  has_many :photos
  has_many :sponsorships
  has_many :ticket_types
  has_many :organizers
  mount_uploader :logoLink, PhotoUploader

  validates :name, presence: true
  validates :numGuests, presence: true
  validates :ticketsLeft, presence: true
  validates :registerStart, presence: true
  validates :registerEnd, presence: true

  #attr_acc for passing host/people variables
  attr_accessor :hostName
  attr_accessor :hostPhone
  attr_accessor :hostEmail
  attr_accessor :person_id
  
  before_validation(on: :create) do |t|
  	if self.ticketsLeft == nil or self.ticketsLeft == 0
  		self.ticketsLeft = self.numGuests
  	end
  end
end
