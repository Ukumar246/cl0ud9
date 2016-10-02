class CreatePeople < ActiveRecord::Migration[5.0]
  def change
    create_table :people do |t|
      t.string :fName
      t.string :lName
      t.date :birthDate
      t.string :email
      t.boolean :allowUserEmails
      t.string :pword
      t.string :profilePicLink
      t.string :twitterLink
      t.string :fbLink

      t.timestamps
    end
  end
end
