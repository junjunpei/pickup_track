class AddColumnsToTracks < ActiveRecord::Migration[6.0]
  def change
    add_column :tracks, :artist_id, :string, null: false
    add_column :tracks, :track_url, :text, null: false
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
