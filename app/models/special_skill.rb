class SpecialSkill < ApplicationRecord
  # relation
  belongs_to :instrument_type
  has_many :instrument_to_special_skills
  has_many :instruments, through: :instrument_to_special_skills

  # scope
  scope :by_id, ->(special_skill_id) { where id: special_skill_id }
end
