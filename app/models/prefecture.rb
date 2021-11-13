class Prefecture < ApplicationRecord
  # relation
  belongs_to :user

  #scope
  scope :by_id, ->(prefecture_id) { where id: prefecture_id }
end
