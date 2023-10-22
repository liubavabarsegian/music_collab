class Group < ApplicationRecord
  belongs_to :leader, foreign_key: 'leader_id', class_name: 'User'

  belongs_to :country
  belongs_to :region
  belongs_to :city

  has_many :group_genres
  has_many :genres, through: :group_genres, source: :genre
  accepts_nested_attributes_for :group_genres

  has_many :group_instrument_requirements
  has_many :required_instruments, through: :group_instrument_requirements, source: :instrument

  has_many :group_memberships

  def self.ransackable_attributes(auth_object = nil)
    %w[id name leader_id city_id]
  end
end
