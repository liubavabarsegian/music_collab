class Group < ApplicationRecord
  has_one :country
  has_one :region
  has_one :city

  has_many :group_genres, foreign_key: 'group_id'
  has_many :genres, through: :group_genres

  has_many :group_memberships
end
