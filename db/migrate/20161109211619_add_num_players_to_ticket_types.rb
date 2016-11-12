class AddNumPlayersToTicketTypes < ActiveRecord::Migration[5.0]
  def change
    add_column :ticket_types, :numPlayers, :integer
  end
end
