class MusicianInstrument < ApplicationRecord
  belongs_to :musician, foreign_key: 'musician_id', class_name: 'User'
  belongs_to :instrument, foreign_key: 'instrument_id', class_name: 'MusicalInstrument'
end
