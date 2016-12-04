class Sponsorship < ApplicationRecord
  belongs_to :tournament

  validates :name, presence: true
  validates :price, presence: true

  #check for duplication
  validates_uniqueness_of   :name, scope: :tournament

end
