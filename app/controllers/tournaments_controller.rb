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
		@golf_course = get_golf_course_info(@tournament)
		@golf_course_address = @golf_course.addrStreetNum.to_s + ' ' + @golf_course.addrStreetName + ' ' + @golf_course.addrPostalCode
		@host_name = get_host_name(@tournament)
		@sold_out = @tournament.ticketsLeft == 0
		@ticketsLeft = @tournament.ticketsLeft
	end

	def organize
		@tournament = Tournament.find(params[:id])
		@golf_course = get_golf_course_info(@tournament)
		@golf_course_address = @golf_course.addrStreetNum.to_s + ' ' + @golf_course.addrStreetName + ' ' + @golf_course.addrPostalCode
		players = Player.where(tournament_id: @tournament.id)
		player_ids = players.map { |player| player.person_id }
		@people = Person.where(id: player_ids)

		return @people
	end

	def new	
		#originally index all golf_courses for the select field. The value is updated using ajax
		@golf_course = GolfCourse.all
		@tournament = Tournament.new
	end

	def create
		@tournament = Tournament.new(tournament_params)
		if @tournament.ticketsLeft == nil
			@tournament.ticketsLeft = @tournament.numGuests
		end
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
		params.require(:tournament).permit(:name, :shortDesc, :tournamentDate, :numGuests, :registerStart, :registerEnd, :logoLink)
	end

	def get_golf_course_info(tournament)
		GolfCourse.find(tournament.golf_course_id)
	end

  def get_host_name (tournament)
      host = Host.find(tournament.host_id)
      host_name = host.hostName
      return host_name
  end
end

