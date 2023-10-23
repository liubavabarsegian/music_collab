class Invitation < ApplicationRecord
  belongs_to :group
  belongs_to :musician, foreign_key: 'musician_id', class_name: 'User'
end
