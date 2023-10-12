class GroupGenre < ApplicationRecord
  belongs_to :group
  belongs_to :genre, foreign_key: 'genre_id', class_name: 'MusicGenre'
end
