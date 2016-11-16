require 'test_helper'

class HostTest < ActiveSupport::TestCase
  test "Should not save a host without a name" do
    host = Host.new
    assert_not host.save, "Saved the host without a name"
  end
end
