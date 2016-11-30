require 'test_helper'

class TournamentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tournament = tournaments(:one)
    person_signed_in = true
    current_person = people(:one)
  end

  test "should get index" do
    get tournaments_url
    assert_response :success
  end
  test "should get new if signed in" do
    get new_tournament_url
    assert_redirected_to :action => 'index'
  end

  test "should create tournament" do
    assert_difference('Tournament.count') do
      post tournaments_url, params: { tournament: { name:'Name', shortDesc: 'Description', tournamentDate:'2009-01-09 17:00:00', numGuests:50, registerStart:'2009-01-09 17:00:00', registerEnd:'2009-01-09 17:00:00', logoLink:"puppy.jpg", person_id: people(:one).id } }
    end

    assert_redirected_to :action => 'organize', id: Tournament.last.id
  end

end
