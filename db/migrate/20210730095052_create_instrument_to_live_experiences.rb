class CreateInstrumentToLiveExperiences < ActiveRecord::Migration[6.1]
  def change
    create_table :instrument_to_live_experiences do |t|
      t.references :instrument, foreign_key: true
      t.references :live_experience, foreign_key: true
      t.timestamps
    end
  end
end
