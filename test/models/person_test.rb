require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  test "Should not save a person without a first name" do
    person = Person.new
    assert_not person.save, "Saved the person without a first name"
  end
end
