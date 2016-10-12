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
			params.require(:tournament).permit(:name, :shortDesc, :tournamentDate, :numGuests, :registerStart, :registerEnd)
		end
		
	private
		def get_golf_course_address (tournament)
			golf_course_address = GolfCourse.find(tournament.golf_course_id)
			golf_course_address = golf_course_address.addrStreetNum.to_s + ' ' + 	golf_course_address.addrStreetName + ' ' + golf_course_address.addrPostalCode
		return golf_course_address
	end

  
end