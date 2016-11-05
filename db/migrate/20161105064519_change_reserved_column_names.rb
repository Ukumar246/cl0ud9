class ChangeReservedColumnNames < ActiveRecord::Migration[5.0]
  def change
    change_table :scheduled_events do |s|
      s.rename :time, :startTime
    end
  end
end
