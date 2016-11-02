class ChangePhoneLength < ActiveRecord::Migration[5.0]
  def change
    change_column :golf_courses, :phone, :integer, :limit => 8
  end
end
