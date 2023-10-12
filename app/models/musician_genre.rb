class MusicianGenre < ApplicationRecord
  belongs_to :musician, foreign_key: 'musician_id', class_name: 'User'
  belongs_to :genre, foreign_key: 'genre_id', class_name: 'MusicGenre'
end
