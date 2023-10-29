class Request < ApplicationRecord
  STATUSES = {
    pending:    'pending',
    accepted:   'accepted',
    denied:     'denied',
    cancelled:  'cancelled'
  }

  validates_inclusion_of :status, in: STATUSES.values, allow_nil: true

  belongs_to :group
  belongs_to :musician, foreign_key: 'musician_id', class_name: 'User'
  belongs_to :instrument, foreign_key: 'instrument_id', class_name: 'MusicalInstrument'
end
