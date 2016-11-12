class Player < ApplicationRecord
  belongs_to :person
  belongs_to :tournament
  belongs_to :team
  belongs_to :ticket_type

  attr_accessor :numTickets
end
