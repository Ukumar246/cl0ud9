class TournamentsController < ApplicationController
	
	def index
		@addresses = Array.new

		@tournaments = Tournament.all


		@count = Tournament.count
		#@tournaments.each do |t|
		#	@addresses.push(get_golf_course_address(t))
		#end
	end

	def show
		@tournament = Tournament.find(params[:id])
		@golf_course_address = get_golf_course_address(@tournament)
		@golf_course_name = get_golf_course_name(@tournament)
		@golf_course_phone = get_golf_course_phone(@tournament)
		#@host_name = get_host_name(@tournament)
	end

	def new	
		#originally index all golf_courses for the select field. The value is updated using ajax
		@golf_course = GolfCourse.all
		@tournament = Tournament.new
	end

	def create
		@tournament = Tournament.new(tournament_params)
	if @tournament.save
		#Create the organizer entry for the tournament
		
		@organizer = Organizer.new
		@organizer.person_id = params[:tournament][:person_id]
		@organizer.permissions = ""
		
		if(@organizer.save)
			flash[:notice] = "Successfully created Tournament"
			redirect_to :action => 'show', :id => @tournament
		else 
			render :action =>'new'
		end
	else
		@tournament.errors.full_message
		render :action =>'new'
	end

	end

	def update

	end
	
	def update_courses
		@golf_course = GolfCourse.where("LOWER(name) LIKE ?", "%#{params[:search_value].downcase}%")
		
		respond_to do |format|
			format.js
		end
		
	end

	private
		def tournament_params
			params.require(:tournament).permit(:name, :shortDesc, :tournamentDate, :numGuests, :registerStart, :registerEnd, :logoLink, :golf_course_id, :course_name, :course_addr)
		end

	private
		def get_golf_course_address (tournament)
			if(tournament.golf_course_id)
				golf_course_address = GolfCourse.find(tournament.golf_course_id)
				golf_course_address = golf_course_address.addrStreetNum.to_s + ' ' + 	golf_course_address.addrStreetName + ' ' + golf_course_address.addrPostalCode
			else 
				golf_course_address = tournament.course_addr
			end
		return golf_course_address
	end

  private
  def get_golf_course_name (tournament)
	if(tournament.golf_course_id)
		golf_course = GolfCourse.find(tournament.golf_course_id)
		golf_course_name = golf_course.name
	else 
		golf_course_name = tournament.course_name
	end
     return golf_course_name
  end

  private
  def get_golf_course_phone (tournament)
	if(tournament.golf_course_id)
		golf_course = GolfCourse.find(tournament.golf_course_id)
		golf_course_phone = golf_course.phone
		return golf_course_phone
	else 
		return nil
	end
  end

	private
  def get_host_name (tournament)
      host = Host.find(tournament.host_id)
      host_name = host.hostName
      return host_name
  end
end