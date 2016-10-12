require 'test_helper'

class PlayerControllerTest < ActionDispatch::IntegrationTest
  test "should get profiles" do
    get player_profiles_url
    assert_response :success
  end

end
