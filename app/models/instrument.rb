class Instrument < ApplicationRecord
  # relation
  belongs_to :user
  belongs_to :instrument_type, optional: true
  has_many :instrument_to_special_skills, dependent: :destroy
  has_many :special_skills, through: :instrument_to_special_skills
  has_many :instrument_to_equipments, dependent: :destroy
  has_many :equipments, through: :instrument_to_equipments
  has_many :instrument_to_live_experiences, dependent: :destroy
  has_many :live_experiences, through: :instrument_to_live_experiences

  # validation
  validates :experience, presence: true
  validates :skill_level, presence: true
  validates :position, presence: true

  def bulk_upsert_join_table(instrument_params, errors, mode)
    Instruments::UpsertJoinTableService.new(self.id, instrument_params, errors, mode).call
  end

  EXPERIENCE =
    {
      0 => '1 年未満',
      1 => '1 ~ 3 年',
      2 => '3 ~ 5 年',
      3 => '5 ~ 10 年',
      4 => '10 年以上'
    }

  EXPERIENCE_HASH_IN_ARRAY = [
    { id: 0, value: '1 年未満' },
    { id: 1, value: '1 ~ 3 年' },
    { id: 2, value: '3 ~ 5 年' },
    { id: 3, value: '5 ~ 10 年' },
    { id: 4, value: '10 年以上' }
  ]
  
  SKILL_LEVEL =
    { 
      0 => '初級レベル',
      1 => '中級レベル',
      2 => '上級レベル'
    }
  
  SKILL_LEVEL_HASH_IN_ARRAY = [
    { id: 0, value: '初級レベル' },
    { id: 1, value: '中級レベル' },
    { id: 2, value: '上級レベル' }
  ]
  
end
