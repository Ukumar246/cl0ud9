class AddTournamentIdToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_reference :photos, :tournament, foreign_key: true
  end
end
