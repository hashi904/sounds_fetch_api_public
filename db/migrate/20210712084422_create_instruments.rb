class CreateInstruments < ActiveRecord::Migration[6.1]
  def change
    create_table :instruments do |t|
      t.integer :experience, null:false      
      t.integer :skill_level, null:false
      t.integer :live_experience, null:false      
      t.integer :position, null:false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
