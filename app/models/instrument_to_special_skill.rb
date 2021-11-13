class InstrumentToSpecialSkill < ApplicationRecord
  # relation
  belongs_to :instrument
  belongs_to :special_skill

  # validation
  validates :instrument_id, presence: true
  validates :special_skill_id, presence: true
end
