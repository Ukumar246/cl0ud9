class MessageMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.message_mailer.Mailer.subject
  #
  def Mailer
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  def new_message(message)
    @message = message
    
    mail subject: "Contact Us Form"
  end

end
