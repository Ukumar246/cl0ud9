# Preview all emails at http://localhost:3000/rails/mailers/general_mailer
class GeneralMailerPreview < ActionMailer::Preview
  def ticket_confirmation_email
  	@players = Player.find([1,10])
  	@players.each{|p| p.QRCodeStr = "hello world" + p.id.to_s}
    GeneralMailer.ticket_confirmation_email(@players)
  end
end
