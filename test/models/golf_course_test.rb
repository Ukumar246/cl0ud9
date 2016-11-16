require 'test_helper'

class GolfCourseTest < ActiveSupport::TestCase
  test "Should not save a golf_course without a name" do
    golf_course = GolfCourse.new
    assert_not golf_course.save, "Saved the golf course without a name"
  end
end
