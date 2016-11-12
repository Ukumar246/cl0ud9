class GeneralMailer < ApplicationMailer
default from: 'cl0ud9golfing@gmail.com'

	def ticket_confirmation_email (newPlayers)
		@players = newPlayers
		@subject = 'Your ' + @players.first.tournament.name + ' tickets'
		mail(to: @players.first.person.email, subject: @subject)
	end
end
