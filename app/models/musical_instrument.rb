class MusicalInstrument < ApplicationRecord
  has_many :group_instrument_requirements
  has_many :groups, through: :group_instrument_requirements, source: :group

  has_many :group_memberships
end
