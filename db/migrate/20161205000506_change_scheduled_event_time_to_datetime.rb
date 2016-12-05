class ChangeScheduledEventTimeToDatetime < ActiveRecord::Migration[5.0]
  def change  	
  	remove_column :scheduled_events, :startTime
    add_column :scheduled_events, :startTime, :datetime
  end
end
