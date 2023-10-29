class Request < ApplicationRecord
  STATUSES = {
    pending:    'pending',
    accepted:   'accepted',
    declined:   'declined',
    cancelled:  'cancelled'
  }

  validates_inclusion_of :status, in: STATUSES.values, allow_nil: true

  belongs_to :group
  belongs_to :musician, foreign_key: 'musician_id', class_name: 'User'
end
