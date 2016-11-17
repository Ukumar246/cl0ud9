class TicketType < ApplicationRecord
  belongs_to :tournament

  validates :name, presence: true

  def select_option
  	"#{name} $#{'%.2f' %price}"
  end
end
