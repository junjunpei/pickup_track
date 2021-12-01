class CreateTracks < ActiveRecord::Migration[6.0]
  def change
    create_table :tracks do |t|
      t.string :track_id, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
      t.index [:user_id, :track_id], unique: true
    end
  end
end
