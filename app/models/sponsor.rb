class Sponsor < ApplicationRecord
  belongs_to :person
  belongs_to :tournament

  validates :sponsorshipType, presence: true
  #TODO: Other validation
end
