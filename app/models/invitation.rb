class Invitation < ApplicationRecord
  STATUSES = {
    pending:    'pending',
    accepted:   'accepted',
    denied:     'denied',
    cancelled:  'cancelled'
  }

  STATUSES_RU = {
    pending:    'в ожидании',
    accepted:   'принято',
    denied:     'отклонено',
    cancelled:  'отменено'
  }

  belongs_to :group
  belongs_to :musician, foreign_key: 'musician_id', class_name: 'User'
end
