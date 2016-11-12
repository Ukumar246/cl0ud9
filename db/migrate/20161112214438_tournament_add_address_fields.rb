class TournamentAddAddressFields < ActiveRecord::Migration[5.0]
  def change
	add_column :tournaments, :course_name, :string
	add_column :tournaments, :course_addr, :string
  end
end
