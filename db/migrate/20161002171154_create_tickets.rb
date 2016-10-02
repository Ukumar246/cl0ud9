class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.references :ticket_type, foreign_key: true
      t.string :QRCodeLink

      t.timestamps
    end
  end
end
