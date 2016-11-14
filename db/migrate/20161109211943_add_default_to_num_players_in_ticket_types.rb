class AddDefaultToNumPlayersInTicketTypes < ActiveRecord::Migration[5.0]
  def change
  	change_column_default :ticket_types, :numPlayers, 1
  end
end
