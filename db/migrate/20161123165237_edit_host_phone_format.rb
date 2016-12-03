class EditHostPhoneFormat < ActiveRecord::Migration[5.0]
  def change
	remove_column :hosts, :phone
	add_column :hosts, :phone, :bigint
  end
end
