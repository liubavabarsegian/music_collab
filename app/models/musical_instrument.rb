class MusicalInstrument < ApplicationRecord
  has_many :group_instrument_requirements
  has_many :groups, through: :group_instrument_requirements, source: :group

  has_many :group_memberships

  def self.ransackable_attributes(auth_object = nil)
    %w[name]
  end
end
