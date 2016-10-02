class CreateCloud9People < ActiveRecord::Migration[5.0]
  def change
    create_table :cloud9_people do |t|
      t.references :person, foreign_key: true
      t.string :permissions

      t.timestamps
    end
  end
end
