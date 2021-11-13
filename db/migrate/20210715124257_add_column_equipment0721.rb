class AddColumnEquipment0721 < ActiveRecord::Migration[6.1]
  def change
    add_reference :equipment, :instrument_type, foreign_key: true
  end
end
