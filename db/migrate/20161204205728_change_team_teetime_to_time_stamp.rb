class ChangeTeamTeetimeToTimeStamp < ActiveRecord::Migration[5.0]
  def change
  	remove_column :teams, :teeTime
    add_column :teams, :teeTime, :datetime
  end
end
