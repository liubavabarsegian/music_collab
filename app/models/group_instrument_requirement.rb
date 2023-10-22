class GroupInstrumentRequirement < ApplicationRecord
  belongs_to :group
  belongs_to :instrument, foreign_key: 'instrument_id', class_name: 'MusicalInstrument'
end
