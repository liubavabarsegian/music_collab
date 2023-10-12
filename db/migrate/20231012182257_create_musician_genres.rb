class CreateMusicianGenres < ActiveRecord::Migration[7.0]
  def change
    create_table :musician_genres do |t|
      t.integer :musician_id
      t.integer :genre_id

      t.timestamps
    end
  end
end
