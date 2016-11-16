class Host < ApplicationRecord
  validates :hostName, presence: true
end
