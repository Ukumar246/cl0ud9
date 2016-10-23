class GolfCourse < ApplicationRecord

  #   only validate the address for Google Maps purposes and the name and email for correct data display and usage
  #   dont validate website url, logo link because a lot of the old clubs may not have it
  #   dont validate capacity as the owners may not know. Can change later if needed

  validates :email, presence: true
  validates :email, format: { with: /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\z/, message: 'Please enter a valid email address E.g. john.smith@gmail.com' }

  validates :name, presence: true
  validates :name, format: { with: /\A[a-zA-Z\s]\z/, message: 'Please enter letters in name only E.g. Country Club' }

  validates :addrStreetNum, presence: true
  validates :addrStreetNum, format: { with: /\A[a-zA-Z0-9]\z/, message: 'Please enter letters and numbers in street number only E.g. 244 or 244A' }

  validates :addrStreetName, presence: true
  validates :addrStreetName, format: { with: /\A\s*\S+(?:\s+\S+){2}\z/, message: 'Please enter a valid street name E.g. St. George Street' }

  # checks for canadian for now
  validates :addrPostalCode, presence: true
  validates :addrPostalCode, format: { with: /\A[A-Za-z]\d[A-Za-z][ -]?\d[A-Za-z]\z/, message: 'Please enter a valid postal code E.g. M2N 6N3' }

  validates :addrCountry, presence: true
  validates :addrCountry, format: { with: /\Aa-zA-Z]{2,}\z/, message: 'Please enter a valid country name E.g. Canada' }


end
