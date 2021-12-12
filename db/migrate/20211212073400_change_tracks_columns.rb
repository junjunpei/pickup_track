class ChangeTracksColumns < ActiveRecord::Migration[6.0]
  def change
    add_column :tracks, :name, :text
    add_column :tracks, :artist_name, :text
    add_column :tracks, :album_name, :text
    add_column :tracks, :image_url, :text
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
