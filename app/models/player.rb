class Player < ApplicationRecord
  belongs_to :person
  belongs_to :tournament
  belongs_to :team
  belongs_to :ticket_type

  attr_accessor :numTickets

  validates :QRCodeStr, uniqueness: true, if: ':QRCodeStr.present?'

  after_create(on: :create) do |p|
  	#so that qr codes will be unique even if one person buys a number of tickets
  	p.QRCodeStr = p.person.email + p.id.to_s + p.ticket_type.name + p.tournament.name + DateTime.now.to_s
  	p.save
  end
end
