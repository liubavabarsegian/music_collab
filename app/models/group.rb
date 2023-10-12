class Group < ApplicationRecord
  has_many :group_genres, foreign_key: 'group_id'
  has_many :genres, through: :group_genres
end
