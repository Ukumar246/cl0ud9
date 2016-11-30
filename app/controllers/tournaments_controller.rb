class TournamentsController < ApplicationController
 	helper_method :sort_column, :sort_direction
	def index
		@addresses = Array.new
		@tournaments = Tournament.order(sort_column + ' ' + sort_direction)
		@count = Tournament.count
		#@tournaments.each do |t|
		#	@addresses.push(get_golf_course_address(t))
		#end
	end

	def destroy
		assert_user_can_organize(@tournament)

		@players = Player.where(tournament_id: params[:id])
		@players.destroy_all
		@ticket_types = TicketType.where(tournament_id: params[:id])
		@ticket_types.destroy_all

		@tournament = Tournament.find(params[:id])
		@tournament.destroy
		redirect_to :action => 'index'
	end

	def show
		@tournament = Tournament.find(params[:id])
		private_required()
		#use get_golf_course_address to fill the following three values
		@course_name = nil
		@course_address = nil
		@course_phone = nil

		get_golf_course_info(@tournament)

		@host_name = get_host_name(@tournament)
		@sold_out = @tournament.ticketsLeft == 0
		@ticketsLeft = @tournament.ticketsLeft
		@tournament_organizer = current_user_is_organizer(@tournament)
	end

	def private_url

		@tournament = Tournament.find(params[:id])

		#use get_golf_course_address to fill the following three values
		@course_name = nil
		@course_address = nil
		@course_phone = nil

		get_golf_course_info(@tournament)

		@host_name = get_host_name(@tournament)
		@sold_out = @tournament.ticketsLeft == 0
		@ticketsLeft = @tournament.ticketsLeft
		@tournament_organizer = current_user_is_organizer(@tournament)
	end

	def organize
		@tournament = Tournament.find(params[:id])
		assert_user_can_organize(@tournament)

			if(@golf_course = GolfCourse.find(@tournament.golf_course_id))
				@golf_course_address = @golf_course.addrStreetNum.to_s + ' ' + @golf_course.addrStreetName + ' ' + @golf_course.addrPostalCode
			else
				@golf_course_address = @tournament.course_name + @tournament.course_addr
			end

			#Get the players in the tournaments
			players = Player.where(tournament_id: @tournament.id)
			player_ids = players.map { |player| player.person_id }
			@people = Person.where(id: player_ids)

			@host_name = get_host_name(@tournament)

			#Get the hosts for the tournament
			@admins = Organizer.where(tournament_id: @tournament.id)
			#organizer_ids = organizer.map { |organizer| organizer.person_id}
			#@admins = Person.where(id: organizer_ids)
			@person = Person.all
			#return @people

			@organizer_permissions = current_user_permission_level(@tournament)
	end

	def new

		#Add log in check
		if(current_person)
			#originally index none of the golf_course and hosts. The value is updated using ajax
			@golf_course = GolfCourse.none
			@host = Host.all
			@tournament = Tournament.new
		else
			flash[:notice] = "Need to be logged in to create tournaments"
			redirect_to :action =>"index"
		end
	end

	def create
		#Create the organizer for the tournament first
		organizer = Organizer.new
		organizer.person_id = params[:tournament][:person_id]
		organizer.permissions = 'FULL'

		#create the host
		host = Host.new

		if(organizer.save)
			#Create the host entry if needed
			if(params[:tournament][:hostName].present?)
				host.hostName = params[:tournament][:hostName]
				host.email = params[:tournament][:hostEmail]
				host.phone = params[:tournament][:hostPhone]

				host.save
			end
		end
		#Create the organizer entry for the tournament

		@organizer = Organizer.new
		@organizer.person_id = params[:tournament][:person_id]
		@organizer.permissions = ""

		if(@organizer.save)


			#create the tournament
			@tournament = Tournament.new(tournament_params)
			if @tournament.ticketsLeft == nil
				@tournament.ticketsLeft = @tournament.numGuests
			end

			#set the host_id if it was typed in
			if(params[:tournament][:hostName].present?)
				@tournament.host_id = host.id
			end
			@tournament.privateURL = params[:tournament][:privateURL] == 1 ? false : true

			if(@tournament.save)
				#Update the organizer entry to reflect the tournament entry
				organizer.tournament_id = @tournament.id
				organizer.save

				if @tournament.privateURL
					@privacyObject = PrivateUrl.new(tournament_id: @tournament.id)
					@privacyObject.save
				end

				GeneralMailer.tournament_confirmation_email(@tournament, Person.find(params[:tournament][:person_id]).email).deliver!
				flash[:notice] = "Successfully created Tournament"
				redirect_to :action => 'organize', :id => @tournament

			else
				#delete the table entries for host and organizer if tournament fails
				organizer.destroy
				host.destroy

				flash[:notice] = "Error creating tournament"
				render :action => 'new'
			end
		else
			flash[:notice] = "Error setting up tournament Organizer"
			redirect_to :action =>'index'
		end
	end

	def email
    @player = Player.find_by_person_id(request['player']['id'])
		GeneralMailer.custom_email(@player, request['email_subject'], request['email_body'])
		@curr_person = Person.find(request['player']['id'])
    flash[:success] = 'Email has been sent to ' + @curr_person.fName + ' ' + @curr_person.lName + '.'
    redirect_to :controller => 'tournaments', :action => 'organize', :id => request['id']
	end

	def resend_confirmation
		@player = Player.find_by_person_id(params[:person_id])
		@players = Array.new(1){|i| i=@player};
			GeneralMailer.ticket_confirmation_email(@players).deliver!
		@curr_person = Person.find(params[:person_id])
		flash[:success] = 'Confirmation email has been sent to ' + @curr_person.fName + ' ' + @curr_person.lName + '.'
		redirect_to :controller => 'tournaments', :action => 'organize', :id => params[:id]

	end

   def refund
		 @tournament = Tournament.find(params[:id])
		 @tournament.ticketsLeft += 1
		 @tournament.save

     @player = Player.where(person_id: params[:person_id])
		 @player.destroy_all

		 @curr_person = Person.find(params[:person_id])

		 # TODO: Logic to actually refund payment

     flash[:success] = @curr_person.fName + ' ' + @curr_person.lName + ' has been removed from this tournament.'
     redirect_to :controller => 'tournaments', :action => 'organize', :id => params[:id]
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

	def private_required()
		tourney = Tournament.find(params[:id])
		if tourney
			if tourney.privateURL
			    if not PrivateUrl.where('tournament_id = ? AND key = ?', params[:id], params[:key] ).exists?
			      flash[:error] = 'You do not have permission to view the page you entered'
			      redirect_to '/'
			    end
			end
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

	def current_user_is_organizer (tournament)
		if person_signed_in?
			is_organizer = Organizer.find_by_person_id_and_tournament_id(current_person.id, tournament.id)
			return !is_organizer.nil?
		else
			return false
		end
	end

	def assert_user_can_organize (tournament)
		if !current_user_is_organizer(@tournament)
			flash[:danger] = 'You do not have access to organize this tournament!'
			redirect_to :action => 'show'
		end
	end

	def get_golf_course_info (tournament)
		if(tournament.golf_course_id)
			@golf_course = GolfCourse.find(tournament.golf_course_id)
			@course_address = @golf_course.addrStreetNum.to_s + ' ' + @golf_course.addrStreetName + ' ' + @golf_course.addrPostalCode
			@course_name = @golf_course.name
			@course_phone = @golf_course.phone
		else
			@course_address = tournament.course_addr
			@course_name = tournament.course_name
			@course_phone = nil
		end
	end

	def current_user_permission_level(tournament)
		organizer = Organizer.find_by_person_id_and_tournament_id(current_person.id, tournament.id)
		if(organizer.permissions == "EDIT")
			return false
		elsif (organizer.permissions == "FULL")
			return true
		end
		return false
	end
  def sort_column
    Tournament.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end
end
