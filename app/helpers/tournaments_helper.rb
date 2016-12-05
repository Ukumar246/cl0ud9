module TournamentsHelper
	def get_time_from_tournament_date(tournament)
		@hour = tournament.tournamentDate.hour
		@minute = tournament.tournamentDate.min
	end
end
