class CreateSponsors < ActiveRecord::Migration[5.0]
  def change
    create_table :sponsors do |t|
      t.references :person, foreign_key: true
      t.references :tournament, foreign_key: true
      t.string :type
      t.string :logoLink
      t.string :websiteURL
      t.string :twitterLink
      t.string :fbLink
      t.string :snapchatHandle

      t.timestamps
    end
  end
end
