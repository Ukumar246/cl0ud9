class TeamsController < ApplicationController
	def create
		@newteam = Teams.new(params)
		@tournament = Tournaments.find(@team[:tournament_id])
		@allTeams = Tournaments.Teams.allTeams

		if @allTeams 
			@lastTee = @allTeams.last.teeTime
			@newteam.teeTime = @lastTee + 20.minutes
		else
			@tourneyStart = @tournament[:tournamentDate]
			@newteam.teeTime = @tourneyStart + 10.minutes
		end
		@newteam.save

	end	
end
