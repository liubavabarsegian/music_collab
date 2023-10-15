class Group < ApplicationRecord
  belongs_to :leader, foreign_key: 'leader_id', class_name: 'User'
  has_one :country
  has_one :region
  has_one :city

  has_many :group_genres
  has_many :genres, through: :group_genres, source: :genre
  accepts_nested_attributes_for :group_genres

end
