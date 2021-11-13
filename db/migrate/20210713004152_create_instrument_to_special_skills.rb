class CreateInstrumentToSpecialSkills < ActiveRecord::Migration[6.1]
  def change
    create_table :instrument_to_special_skills do |t|
      t.references :instrument, foreign_key: true
      t.references :special_skill, foreign_key: true
      t.timestamps
    end
  end
end
