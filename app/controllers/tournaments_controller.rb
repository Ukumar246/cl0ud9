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
		
		#use get_golf_course_address to fill the following three values
		@course_name = nil
		@course_address = nil
		@course_phone = nil
		
		if(@tournament.golf_course_id)
			@golf_course = GolfCourse.find(@tournament.golf_course_id)
			@course_address = @golf_course.addrStreetNum.to_s + ' ' + @golf_course.addrStreetName + ' ' + @golf_course.addrPostalCode
			@course_name = @golf_course.name
			@course_phone = @golf_course.phone
		else 
			@course_address = @tournament.course_addr
			@course_name = @tournament.course_name
			@course_phone = nil
		end
		
		@host_name = get_host_name(@tournament)
		@sold_out = @tournament.ticketsLeft == 0
		@ticketsLeft = @tournament.ticketsLeft
	end

	def organize
	
		#Added checking for none golf_course_id referencing tournaments
	
		@tournament = Tournament.find(params[:id])
		if(@golf_course = GolfCourse.find(@tournament.golf_course_id))
			@golf_course_address = @golf_course.addrStreetNum.to_s + ' ' + @golf_course.addrStreetName + ' ' + @golf_course.addrPostalCode
		else
			@golf_course_address = @tournament.course_name + @tournament.course_addr
		end
		players = Player.where(tournament_id: @tournament.id)
		player_ids = players.map { |player| player.person_id }
		@people = Person.where(id: player_ids)

		return @people
	end

	def new	
		#originally index all golf_courses for the select field. The value is updated using ajax
		@golf_course = GolfCourse.all
		@host = Host.all
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
			redirect_to :action => 'organize', :id => @tournament
		else 
			render :action =>'new'
		end
	else
		@tournament.errors.full_messages
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
	
	def update_hosts 
		@host = Host.where("LOWER(name) LIKE ?", "%#{params[:search_host_value].downcase}%")
		
		respond_to do |format|
			format.js
		end
	end

	private
	def tournament_params
		params.require(:tournament).permit(:name, :shortDesc, :tournamentDate, :numGuests, :registerStart, :registerEnd, :logoLink, :golf_course_id, :course_name, :course_addr, :host_id)
	end


	def get_host_name (tournament)
		if(@tournament.host_id)
			host = Host.find(tournament.host_id)
			host_name = "Hosted By: " + host.hostName
		else 
			host_name = "There are no hosts for this tournament currently"
		end
		
		return host_name
	end
end

