class AffectedMusician < ApplicationRecord
  # relation
  has_many :users, through: :user_to_affected_musicians
  has_many :user_to_affected_musicians

  # validation
  # validates :name, presence: true

  # scope
  scope :by_id, ->(musician_id) { where id: musician_id }
end
