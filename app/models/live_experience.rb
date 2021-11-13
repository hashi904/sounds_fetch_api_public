class LiveExperience < ApplicationRecord
  # relation
  belongs_to :instrument
  has_many :instrument_to_live_experiences
  has_many :instruments, through: :instrument_to_live_experiences

  # scope
  scope :by_id, ->(live_experience_id) { where id: live_experience_id }

  #type column 対応
  self.inheritance_column = :_type_disabled
end
