class Team < ApplicationRecord
  belongs_to :tournament

  def self.assign_next_tee_time(team, tournament_id)
		tournament = Tournament.find(tournament_id)
		allTeams = tournament.teams
		tourneyStart = tournament[:tournamentDate]
		if allTeams.nil? or allTeams.empty? 
			puts "all teams empty"
			puts "start: " + (tourneyStart + 10.minutes).to_s
			newteam.teeTime = tourneyStart + 10.minutes
		else
			teamsWithTimes = allTeams.where.not(teeTime: nil).order('"teeTime" asc')
			puts "all teams not empty"
			if teamsWithTimes.last.nil?
				team.teeTime = tourneyStart + 10.minutes
			else
				team.teeTime = teamsWithTimes.last.teeTime + 20.minutes
			end
		end
		team.save
	end
end
