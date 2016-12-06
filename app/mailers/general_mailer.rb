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

	def refund_email (person, tournament_name)
		subject = 'Refund for ' + tournament_name + ' tickets'
		mail(to: person.email, subject: subject)
	end

	def invite_email(emailAddress, tournament_name, tournament)
		puts "Sending email to address ", emailAddress
		@tourney = tournament
		@message = 'You are invited to join Cl0ud9 Golfing Tournament: ' + tournament_name + '.'
		mail(to: emailAddress, subject: 'Invite to ' + tournament_name)
	end

end
