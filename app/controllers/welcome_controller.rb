class WelcomeController < ApplicationController
  def index
  #   Query 1: need to display recent tournaments (within the upcoming month)
  #   - need : Tournament.order(by date to display recent ones)
  #   - need: .includes for hosts and venues
  #   - need: limit of 3-4 ish ish... maybe 5
  #   debugging purposes
  #   @newGolfCourse = GolfCourse.find_by(name:'Last Pre Validation GC')
    @tournaments = Tournament
                       .order(:tournamentDate)
                       .first(3)
  end
end
