class CreateScheduledEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :scheduled_events do |t|
      t.references :tournament, foreign_key: true
      t.time :time
      t.text :description

      t.timestamps
    end
  end
end
