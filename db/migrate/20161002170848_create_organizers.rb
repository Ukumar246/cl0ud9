class CreateOrganizers < ActiveRecord::Migration[5.0]
  def change
    create_table :organizers do |t|
      t.references :person, foreign_key: true
      t.references :tournament, foreign_key: true
      t.string :permissions

      t.timestamps
    end
  end
end
