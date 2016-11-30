class DropTicketsTable < ActiveRecord::Migration[5.0]
 #merge people and tickets columns, they represent the same thing.
  def change
  	remove_reference :people, :ticket, index:true
  	drop_table :tickets
  	
  	add_column :people, :QRCodeStr, :string
  	add_reference :people, :ticket_type, index: true

  end
end
