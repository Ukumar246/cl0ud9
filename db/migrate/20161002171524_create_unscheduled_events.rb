class CreateUnscheduledEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :unscheduled_events do |t|
      t.references :tournament, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
