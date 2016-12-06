class TeamsController < ApplicationController
	def create
		params.permit!
		@team = Team.new(team_params)

		if @team.save
			flash[:success] = 'You have sucessfully created a sponsorship.'
		end

	end	
	
	private
  def team_params
    params.require(:sponsorship).permit(:tournament_id, :numPlayers, :teeTime)
  end
end
