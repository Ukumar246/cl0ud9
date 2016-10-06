class TournamentsController < ApplicationController
  def show
    @tournament = Tournament.find(params[:id])
    get_golf_course_address
  end

  private
  def get_golf_course_address
    @golf_course_address = GolfCourse.find(@tournament.golf_course_id)
    @golf_course_address = @golf_course_address.addrStreetNum.to_s + ' ' + @golf_course_address.addrStreetName + ' ' + @golf_course_address.addrPostalCode
  end
end
