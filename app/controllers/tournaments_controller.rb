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
	end

	def organize
		@tournament = Tournament.find(params[:id])
		players = Player.where(tournament_id: @tournament.id)
		player_ids = players.map { |player| player.person_id }
		@people = Person.where(id: player_ids)

		return @people
	end

	def new
		@tournament = Tournament.new
	end

	def create
		@tournament = Tournament.new(tournament_params)
	if @tournament.save
		flash[:notice] = "Successfully created Tournament"
		redirect_to :action => 'show', :id => @tournament
	else
		@tournament.errors.full_message
		render :action =>'new'
	end
	end


	def update
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
