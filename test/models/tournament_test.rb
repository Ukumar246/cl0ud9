require 'test_helper'

class TournamentTest < ActiveSupport::TestCase
  test "Should not save a tournament without a name" do
    tournament = Tournament.new
    assert_not tournament.save, "Saved the tournament without a name"
  end
end
