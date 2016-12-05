class TournamentsController < ApplicationController
 	helper_method :sort_column, :sort_direction
	def index
		@addresses = Array.new
		@count = Tournament.where(privateURL: false).count

		if params[:sort] == "host"
      		@tournaments = sort_by_hostName
  	elsif params[:sort] == "course_name"
  		@tournaments = sort_by_course_name
  	elsif params[:sort] == "tournamentDate"
  		@tournaments = sort_by_date
  	else
      @tournaments = sort
		end

    #so that the create modal will work
    init_tournament_and_associations

		#@tournaments.each do |t|
		#	@addresses.push(get_golf_course_address(t))
		#end
	end

	def destroy
    @tournament = Tournament.find(params[:id])
		assert_user_can_organize(@tournament)

		@players = Player.where(tournament_id: params[:id])
		@players.destroy_all
    @organizers = Organizer.where(tournament_id: params[:id])
    @organizers.destroy_all
    @sponsors = Sponsor.where(tournament_id: params[:id])
    @sponsors.destroy_all
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
		@organize = true

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

		@course_name = nil
		@course_address = nil
		@course_phone = nil
    @host = @tournament.host
    @teams = @tournament.teams.order('"teeTime" asc')
    get_data_for_reports(@tournament)
		get_golf_course_info(@tournament)
		@sched_events = @tournament.scheduled_events.order('"startTime" asc')

		setDate = (@tournament.tournamentDate.nil?) ? 0.0 : 0.1
		setRegDates = (@tournament.registerStart.nil?) ? 0.0 : 0.1
		setCourse = (@tournament.golf_course.nil?) ? 0.0 : 0.1
		setnumGuests = (@tournament.numGuests.nil?) ? 0.0 : 0.1
		setDescription = (@tournament.shortDesc.nil? or @tournament.shortDesc.empty?) ? 0.0 : 0.1
		setTime = (@tournament.tournamentDate.hour == 0 and @tournament.tournamentDate.min == 0) ? 0.0 : 0.1
		setLogo= (@tournament.logoLink?) ? 0.0 : 0.1
		setEvent= (@tournament.scheduled_events.nil? and @tournament.unscheduled_events.nil?) ? 0.0 : 0.1
		setPhoto= (@tournament.photos.nil?) ? 0.0 : 0.1
		@setHost = (@tournament.host.nil?) ? 0.0 : 0.1
		@percentage_done = (setDate + setRegDates + setCourse + setnumGuests + setDescription + setTime + setLogo + setEvent + setPhoto + @setHost)*100

	end

	def new
		init_tournament_and_associations
	end

  def update
    @tournament = Tournament.find(params[:id])
    @tournament.update(tournament_params)

    redirect_to :action => 'organize'
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

			#create the tournament
			@tournament = Tournament.new(tournament_params)
			if @tournament.ticketsLeft == nil
				@tournament.ticketsLeft = @tournament.numGuests
			end

			#set the host_id if it was typed in
			if(params[:tournament][:hostName].present?)
				@tournament.host_id = host.id
			end
			@tournament.privateURL = params[:tournament][:privateURL] == "0" ? false : true

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
			@tournament = Tournament.all
			redirect_to :action =>'index'
		end
	end

	def email
    if request['player']['id'].blank?
      @players = Player.where(tournament_id: request['id'])
    else
      @players = Array.new
      @players.push(Player.find_by_person_id_and_tournament_id(request['player']['id'], request['id']))
    end

    @players.each do |p|
      GeneralMailer.custom_email(p, request['email_subject'], request['email_body']).deliver!
    end

    flash[:success] = 'Email has been sent successfully.'
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

	def invite
		emailAddress = params[:q]
		puts "POST NEW FORM FOR INVITE #{emailAddress}"
		@email = GeneralMailer.invite_email(emailAddress).deliver!
	end



  def refund
    @tournament = Tournament.find(params[:id])
    @tournament.ticketsLeft += 1
    @tournament.save

    @player = Player.where(person_id: params[:person_id])
    @player.destroy_all

    @curr_person = Person.find(params[:person_id])
    GeneralMailer.refund_email(@curr_person, @tournament.name).deliver!

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
			    if not PrivateUrl.where('tournament_id = ? AND key = ?', params[:id], params[:key]).exists?
			      flash[:error] = 'You do not have permission to view the page you entered'
			      redirect_to '/'
			    end
			end
		end
	end

	def delete_logo
		@tournament = Tournament.find(params[:id])
    Cloudinary::Api.delete_resources_by_tag(@tournament.logoLink)
    @tournament.remove_logoLink!
    @tournament.save
    redirect_to url_for(:action => :organize, :id=>@tournament.id)
	end

	private
	def tournament_params
		params.require(:tournament).permit(:name, :shortDesc, :tournamentDate, :numGuests, :registerStart, :registerEnd, :privateURL, :person_id, :logoLink, :golf_course_id, :course_name, :course_addr, :host_id, ticket_types_attributes: [:id, :name, :price, :numPlayers,:_destroy])
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

  def get_data_for_reports(tournament)
    ticket_types = TicketType.where(tournament_id: tournament.id)
    @sales_by_ticket_types = Array.new

    ticket_types.each do |tt|
      ticket_sale = {"type" => tt.name}
      players_for_ticket_type = Player.where(ticket_type_id: tt.id)
      if not players_for_ticket_type.nil?
        ticket_sale['sales'] = players_for_ticket_type.length
      else
        ticket_sale['sales'] = 0
      end
      @sales_by_ticket_types.push(ticket_sale)
    end
  end

	def current_user_is_organizer (tournament)
		if person_signed_in?
			is_organizer = Organizer.find_by_person_id_and_tournament_id(current_person.id, tournament.id)
      return ( !is_organizer.nil? or current_user_is_admin(tournament) )
		else
			return false
		end
	end

  def current_user_is_admin (tournament)
    if person_signed_in?
      is_cloud9person = Cloud9Person.find_by_person_id(current_person.id)
      return !is_cloud9person.nil?
    else
      return false
    end
  end

	def assert_user_can_organize (tournament)
		if !current_user_is_organizer(tournament)
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
    if organizer.nil? or organizer.permissions == "EDIT"
      return false
		elsif (organizer.permissions == "FULL")
			return true
		end
		return false
	end

 def sort
	Tournament.order(sort_column + ' ' + sort_direction)
 end

  def sort_column
    params[:sort] ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

  def sort_by_hostName
  	Tournament.order('(SELECT "hostName" from hosts where id = host_id)' + "#{sort_direction}")
   end

   def sort_by_course_name
  	Tournament.order('(SELECT "name" from golf_courses where id = golf_course_id)' + "#{sort_direction}")
   end

   def sort_by_date
	   Tournament.order('"tournamentDate" ' + sort_direction)
   end

   def init_tournament_and_associations
			@golf_course = GolfCourse.none
			@host = Host.all
			@tournament = Tournament.new
			@tournament.ticket_types.build
   end

end
