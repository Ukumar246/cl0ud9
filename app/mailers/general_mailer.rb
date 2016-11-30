class GeneralMailer < ApplicationMailer
default from: 'cl0ud9golfing@gmail.com'

	def ticket_confirmation_email (newPlayers)
		@players = newPlayers
		@subject = 'Your ' + @players.first.tournament.name + ' tickets'
		mail(to: @players.first.person.email, subject: @subject)
	end

	def custom_email (player, subject, message)
		subject = 'A Message from Cl0ud9 - ' + subject
		@message = message
		mail(to: player.person.email, subject: subject)
	end

	def tournament_confirmation_email (tournament, organizer_email)
		@tourney = tournament
		@subject = 'Your tournament confirmation'
		mail(to: organizer_email, subject: @subject)
	end
end
