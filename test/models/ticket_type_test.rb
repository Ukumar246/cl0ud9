require 'test_helper'

class TicketTypeTest < ActiveSupport::TestCase
  test "Should not save a TicketType without a name" do
    ticket_type = TicketType.new
    assert_not ticket_type.save, "Saved the ticket_type without a name"
  end
end
