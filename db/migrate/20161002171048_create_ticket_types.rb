class CreateTicketTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :ticket_types do |t|
      t.references :tournament, foreign_key: true
      t.string :name
      t.string :description
      t.float :price

      t.timestamps
    end
  end
end
