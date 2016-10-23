class GolfCoursesController < ApplicationController
  def _new
  # loads the partial view of the modal form for creating a golf course
  end

  # doesnt have a view
  def create_golf_course
    # permission to access all the golf_course parameters at once
    params.permit!
    @golf_course = GolfCourse.new(params[:golf_course])
    # does validation in model before saving
    if @golf_course.save
      # flash.now for to make the flash disappear after a while
      flash[:success] = 'Your golf course has been registered'
      redirect_to welcome_index_url
    else
      # TODO:need to display te specific errors
      flash[:danger] = @golf_course.errors.full_messages
      redirect_to welcome_index_url
    end
  end
end
