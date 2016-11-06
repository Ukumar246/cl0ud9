class TicketType < ApplicationRecord
  belongs_to :tournament

  def select_option
  	"#{name} $#{'%.2f' %price}"
  end
end
