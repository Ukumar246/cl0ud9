require 'test_helper'

class GolfCoursesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get golf_courses_new_url
    assert_response :success
  end

end
