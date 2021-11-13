class InstrumentToEquipment < ApplicationRecord
  # relation
  belongs_to :instrument
  belongs_to :equipment

  # validation
  validates :instrument_id, presence: true
  validates :equipment_id, presence: true
end
