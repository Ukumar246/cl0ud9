class GolfCourse < ApplicationRecord

  #   only validate the address for Google Maps purposes and the name and email for correct data display and usage
  #   dont validate website url, logo link because a lot of the old clubs may not have it
  #   dont validate capacity as the owners may not know. Can change later if needed

  validates :email, presence: true
  validates :email, format: { with: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, message: 'Please enter a valid email address E.g. john.smith@gmail.com' }

  validates :name, presence: true
  # validates :name, format: { with: /\A[a-zA-Z\s]\z/, message: 'Please enter letters in name only E.g. Country Club' }

  validates :addrStreetNum, presence: true
  validates :addrStreetNum, numericality: { only_integer: true, message: 'Please enter a valid street number e.g. 45' }

  validates :addrStreetName, presence: true
  validates :addrStreetName, format: { with: /^[0-9a-zA-Z. \-]+$/, message: 'Please enter a valid street name E.g. St. George Street', multiline: true}

  # checks for canadian for now
  validates :addrPostalCode, presence: true
  validates :addrPostalCode, format: { with: /^[ABCEGHJKLMNPRSTVXY]{1}\d{1}[A-Z]{1} *\d{1}[A-Z]{1}\d{1}$/, message: 'Please enter a valid postal code E.g. M2N 6N3',multiline: true }

  validates :addrCountry, presence: true
  validates :addrCountry, format: { with: /^[a-zA-Z]+$/, message: 'Please enter a valid country name E.g. Canada', multiline: true }


end
