class AddDefaultPrivateUrlBoolToTournament < ActiveRecord::Migration[5.0]
  def change
  	change_column :tournaments, :privateURL, :boolean, default: false
  end
end
