class InstrumentToLiveExperience < ApplicationRecord
  # relation
  belongs_to :instrument
  belongs_to :live_experience

  # relation
  validates :instrument_id, presence: true
  validates :live_experience_id, presence: true
end
