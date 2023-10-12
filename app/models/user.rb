class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_one :country
  has_one :region
  has_one :city

  has_many :musician_instruments, foreign_key: 'musician_id'
  has_many :musical_instruments, through: :musician_instruments, source: :instrument
end
