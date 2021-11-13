class CreateInstrumentToEquipments < ActiveRecord::Migration[6.1]
  def change
    create_table :instrument_to_equipments do |t|
      t.references :instrument, foreign_key: true
      t.references :equipment, foreign_key: true
      t.timestamps
    end
  end
end
