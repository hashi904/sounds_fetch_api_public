class UserToAffectedMusician < ApplicationRecord
  # relations
  belongs_to :user
  belongs_to :affected_musician

  # validates
  validates :position, presence: true
  validates :user_id, presence: true
  validates :affected_musician_id, presence: true
end
