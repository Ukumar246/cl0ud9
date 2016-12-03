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
  has_one :private_url
  mount_uploader :logoLink, PhotoUploader

  #validate name max length 250, only space, numbers and letters
  validates :name, presence: true
  validates :name, length: {maximum: 250, message: "Enter a name less than 250 characters"}
  
  #validate numGuest as only numeric
  validates :numGuests, presence: true
  validates :numGuests, numericality: {only_integer: true, message: 'Please enter a valid integer'}
  
  validates :shortDesc, presence: true
  validates :shortDesc, length: {maximum: 10000, message: "Enter a description less than 10000 characters"}
  
  #validates tickets left
  validates :ticketsLeft, presence: true
  
  #validate tournamentDate
  validates :tournamentDate, presence: true
  validate :tournamentDate_in_future
  
  validates :registerStart, presence: true
  validates :registerEnd, presence: true
  validate :registration_dates_is_valid
  
  #validate :selected_or_entered_golf_course

  accepts_nested_attributes_for :ticket_types, reject_if: :all_blank, allow_destroy: true

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
  
  private 
  
  def tournamentDate_in_future
	if tournamentDate < Time.zone.today
		errors.add(:tournamentDate, "The tournament cannot be in the past")
	end
  end
  
  def registration_dates_is_valid
	if registerStart < Time.zone.today
		errors.add(:registerStart, "Registration Cannot start in the past")
	elsif registerEnd < registerStart
		errors.add(:registerEnd, "The end date must be greater than the start date")
	end
  end
  
  def selected_or_entered_golf_course
	if !(golf_course_id.blank?)
		if !(course_addr.blank? && course_addr.blank?)
			errors.add(:golf_course_id, "Please either select the golf course or enter in a location")
		end
	elsif (course_name.blank? || course_addr.blank?)
		errors.add(:course_name, "Please Enter both the name and address")
	end
  end
end
