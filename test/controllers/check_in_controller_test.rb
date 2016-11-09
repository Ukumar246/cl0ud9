require 'test_helper'

class CheckInControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get check_in_show_url
    assert_response :success
  end

end
