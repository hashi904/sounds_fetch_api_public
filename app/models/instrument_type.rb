class InstrumentType < ApplicationRecord
  #relation
  has_one :instrument
  has_many :equipments
  has_many :special_skills

  #scope
  scope :by_id, ->(instrument_type_ids) { where id: instrument_type_ids }
end
