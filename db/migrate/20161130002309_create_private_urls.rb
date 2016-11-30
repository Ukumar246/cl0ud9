class CreatePrivateUrls < ActiveRecord::Migration[5.0]
  def change
    create_table :private_urls do |t|
      t.text :key
      t.references :tournament, foreign_key: true

      t.timestamps
    end
  end
end
