class Equipment < ApplicationRecord
  #relation
  belongs_to :instrument_type
  has_many :instrument_to_equipments
  has_many :instruments, through: :instrument_to_equipments

  # scope
  scope :by_id, ->(equipment_id) { where id: equipment_id }
end
