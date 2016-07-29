class CreateFavouriteComics < ActiveRecord::Migration[5.0]
  def change
    create_table :favourite_comics do |t|
      t.integer :comic_id

      t.timestamps
    end
    add_index :favourite_comics, :comic_id, unique: true
  end
end
