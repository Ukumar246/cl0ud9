require 'test_helper'

class GolfCoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @golf_course = golf_courses(:one)
  end

  test "should get new" do
    get new_golf_course_url
    assert_response :success
  end

  test "should create golf_course" do
    assert_difference('GolfCourse.count') do
    post golf_courses_url, params: { golf_course: { name:'Dancing Sheep Golf Club' , phone: '1234567890', addrStreetNum: 20, addrUnitNum: nil, addrStreetName: 'Vanauley Street', addrCity: 'City', addrPostalCode: 'M5T 2H4', addrCountry: 'Canada', logoLink: 'mango.jpg', websiteURL: 'xkcd.com', email: 'DancingSheep@golf.com', capacity: 400} }
  end

    assert_redirected_to welcome_index_url
  end


end
