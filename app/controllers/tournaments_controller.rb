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
		@host_name = get_host_name(@tournament)

		return @people
	end

	def new	
		#originally index all golf_courses for the select field. The value is updated using ajax
		@golf_course = GolfCourse.all
		@host = Host.all
		@tournament = Tournament.new
	end

	def create
	
		#Add permissions check
		if(true)
	    
			#Create the organizer for the tournament first
			organizer = Organizer.new
			organizer.person_id = params[:tournament][:person_id]
			organizer.permissions = 'FULL'
		
			if(organizer.save)
				#Create the host entry if needed 
				if(params[:tournament][:hostName].present?)
					host = Host.new
					host.hostName = params[:tournament][:hostName]
					host.email = params[:tournament][:hostEmail]
					host.phone = params[:tournament][:hostPhone]
			
					host.save
				end
		
				#create the tournament
				@tournament = Tournament.new(tournament_params)
				if @tournament.ticketsLeft == nil
					@tournament.ticketsLeft = @tournament.numGuests
				end
				
				#set the host_id if it was typed in
				if(params[:tournament][:hostName].present?)
					@tournament.host_id = host.id
				end
				
				if(@tournament.save)
					#Update the organizer entry to reflect the tournament entry
					organizer.tournament_id = @tournament.id
					organizer.save
					
					redirect_to :action => 'organize', :id=>@tournament.id
					
				else
					flash[:notice] = "Error creating tournament"
					render :action => 'new'
				end
			else 
				flash[:notice] = "Error setting up tournament Organizer"
				redirect_to :action =>'index'
			end
			
		else 
			flash[:notice] = "Currently not logged in"
			redirect_to:action =>'index'
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

