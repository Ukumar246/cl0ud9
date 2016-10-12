class EditTournaments < ActiveRecord::Migration[5.0]
  def up
	remove_column :tournaments, :sponsored
	remove_column :tournaments, :photoLink
	remove_column :tournaments, :numPhotos
	remove_column :tournaments, :date
	remove_column :tournaments, :time
	add_column		:tournaments, :tournamentDate, :datetime
  end
  
  def down
	remove_column :tournaments, :tournamentDate
	add_column 		:tournaments, :sponsored, :boolean
	add_column 		:tournaments, :photoLink, :string
	add_column 		:tournaments, :numPhotos, :integer
	add_column 		:tournaments, :date, :date
	add_column		:tournaments, :time, :time
  end
end
