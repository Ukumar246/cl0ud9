class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :people do |t|
      t.references :person, foreign_key: true
      t.references :tournament, foreign_key: true
      t.references :team, foreign_key: true
      t.boolean :checkedIn
      t.references :ticket, foreign_key: true

      t.timestamps
    end
  end
end
