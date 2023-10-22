class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :async

  belongs_to :country
  belongs_to :region
  belongs_to :city

  # создание связи [много-ко-многим] между музкантами и инструментами
  has_many :musician_instruments, foreign_key: 'musician_id'
  has_many :musical_instruments, through: :musician_instruments, source: :instrument

  # создание связи [много-ко-многим] между музыкантами и предпочитаемыми ими жанрами
  has_many :musician_genres, foreign_key: 'musician_id'
  has_many :genres, through: :musician_genres, source: :genre

  has_many :group_memberships
  has_many :leading_groups, foreign_key: 'leader_id', class_name: 'Group'

  def self.ransackable_attributes(auth_object = nil)
    %w[id name surname email has_concert_experience career_start_year city_id]
  end

  def leading_groups
    @leading_groups = Group.all.where(leader_id: self.id)
  end
end
