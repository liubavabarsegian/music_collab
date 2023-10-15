class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_one :country
  has_one :region
  has_one :city

  # создание связи [много-ко-многим] между музкантами и инструментами
  has_many :musician_instruments, foreign_key: 'musician_id'
  has_many :musical_instruments, through: :musician_instruments, source: :instrument

  # создание связи [много-ко-многим] между музыкантами и предпочитаемыми ими жанрами
  has_many :musician_genres, foreign_key: 'musician_id'
  has_many :genres, through: :musician_genres, source: :genre

  has_many :group_memberships
  has_many :leading_groups, foreign_key: 'leader_id', class_name: 'Group'
end
