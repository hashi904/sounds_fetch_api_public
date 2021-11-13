class CreateSpecialSkills < ActiveRecord::Migration[6.1]
  def change
    create_table :special_skills do |t|
      t.string :name, null:false
      t.timestamps
    end
  end
end
