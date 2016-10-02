class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.references :tournament, foreign_key: true
      t.integer :numPlayers
      t.time :teeTime

      t.timestamps
    end
  end
end
