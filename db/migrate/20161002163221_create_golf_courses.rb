class CreateGolfCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :golf_courses do |t|
      t.string :name
      t.integer :phone
      t.integer :addrStreetNum
      t.integer :addrUnitNum
      t.string :addrStreetName
      t.string :addrCity
      t.string :addrPostalCode
      t.string :addrCountry
      t.string :logoLink
      t.string :websiteURL
      t.string :email
      t.integer :capacity

      t.timestamps
    end
  end
end
