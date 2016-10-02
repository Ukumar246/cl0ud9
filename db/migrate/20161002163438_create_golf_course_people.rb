class CreateGolfCoursePeople < ActiveRecord::Migration[5.0]
  def change
    create_table :golf_course_people do |t|
      t.references :person, foreign_key: true
      t.references :golf_course, foreign_key: true
      t.string :permissions

      t.timestamps
    end
  end
end
