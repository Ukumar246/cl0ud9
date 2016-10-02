class CreateTournaments < ActiveRecord::Migration[5.0]
  def change
    create_table :tournaments do |t|
      t.string :name
      t.text :shortDesc
      t.time :time
      t.date :date
      t.integer :numGuests
      t.boolean :sponsored
      t.boolean :privateURL
      t.string :microSiteURL
      t.string :logoLink
      t.string :language
      t.string :currency
      t.string :timeZone
      t.string :photoLink
      t.integer :numPhotos
      t.integer :ticketsLeft
      t.timestamp :registerStart
      t.timestamp :registerEnd
      t.references :host, foreign_key: true
      t.references :golf_course, foreign_key: true

      t.timestamps
    end
  end
end
