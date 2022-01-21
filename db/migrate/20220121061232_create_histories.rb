class CreateHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :histories do |t|
      t.references :user, null: false, foreign_key: true
      t.string :track_id, null: false
      t.string :artist_id, null: false
      t.text :name
      t.text :artist_name
      t.text :album_name
      t.text :image_url
      t.text :track_url, null: false

      t.timestamps
    end
  end
end
