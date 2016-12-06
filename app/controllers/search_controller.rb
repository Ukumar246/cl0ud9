class SearchController < ApplicationController
  def index
	@tournaments
	@golf_courses
	search_param = params[:search]
	@tournaments = Tournament.where("LOWER(name) LIKE ?", "%#{params[:search].downcase}%")
	@golf_courses = GolfCourse.where("LOWER(name) LIKE ?", "%#{params[:search].downcase}%")
  end
end
