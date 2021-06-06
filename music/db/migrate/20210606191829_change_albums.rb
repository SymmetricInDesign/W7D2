class ChangeAlbums < ActiveRecord::Migration[5.2]
  def change
    change_table :albums do |t|
      t.integer :band_id
      t.index :band_id
    end
  end
end
