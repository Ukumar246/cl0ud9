class GolfCoursesController < ApplicationController
	
  def new
    print('Came into the new action!')
  # loads the partial view of the modal form for creating a golf course
    render :partial=>'golf_courses/new'
  end

  # doesnt have a view
  def create
    # permission to access all the golf_course parameters at once
    params.permit!
    @golf_course = GolfCourse.new
    # doing them separately because passed in the person_id as a form parameter as well
    @golf_course.name = params[:golf_course][:name]
    @golf_course.phone = params[:golf_course][:phone]
    @golf_course.addrStreetNum = params[:golf_course][:addrStreetNum]
    @golf_course.addrUnitNum = params[:golf_course][:addrUnitNum]
    @golf_course.addrStreetName = params[:golf_course][:addrStreetName]
    @golf_course.addrCity = params[:golf_course][:addrCity]
    @golf_course.addrPostalCode = params[:golf_course][:addrPostalCode]
    @golf_course.addrCountry = params[:golf_course][:addrCountry]
    @golf_course.logoLink = params[:golf_course][:logoLink]
    @golf_course.websiteURL = params[:golf_course][:websiteURL]
    @golf_course.email = params[:golf_course][:email]
    @golf_course.capacity = params[:golf_course][:capacity]
    # does validation in model before saving
    if @golf_course.save
      # flash.now for to make the flash disappear after a while
      # only need the person_id, golf_course_id and the permissions for the golf course people
      @golf_course_person = GolfCoursePerson.new
      @golf_course_person.person_id = params[:golf_course][:person_id]
      @golf_course_person.golf_course_id = @golf_course.id
      # leaving blank permissions for now
      @golf_course_person.permissions = ''
      if @golf_course_person.save
        flash[:success] = 'Your golf course has been registered'
        redirect_to welcome_index_url
      else
        # TODO:need to display te specific errors
        flash[:danger] = @golf_course.errors.full_messages
        redirect_to welcome_index_url
      end
    else
      # TODO:need to display te specific errors
      flash[:danger] = @golf_course.errors.full_messages
      redirect_to welcome_index_url
    end
  end

  def update
    print('Came into update action!')
  end

  def show
    print('Came into the show action!')
  end
  
	def get_courses
		@golf_courses = GolfCourses.where(['name Like ?', "%#{search}%"])
		respond_to do |format|
			format.js
		end
	end
	
end

