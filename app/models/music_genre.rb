class MusicGenre < ApplicationRecord
  has_many :musician_genres
  has_many :musicians, through: :musician_genres

  has_many :group_genres
  has_many :groups, through: :group_genres
end
