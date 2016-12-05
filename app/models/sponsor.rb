class Sponsor < ApplicationRecord
  belongs_to :person
  belongs_to :tournament

  validates :sponsorship_id, presence: true
  #TODO: Other validation
end
