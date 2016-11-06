class DropTicketsTable < ActiveRecord::Migration[5.0]
 #merge players and tickets columns, they represent the same thing.
  def change
  	remove_reference :players, :ticket, index:true
  	drop_table :tickets
  	
  	add_column :players, :QRCodeStr, :string
  	add_reference :players, :ticket_type, index: true

  end
end
