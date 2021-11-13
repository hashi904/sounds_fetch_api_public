class AddColumnSpeciallSkills20210715 < ActiveRecord::Migration[6.1]
  def change
    add_reference :special_skills, :instrument_type, foreign_key: true
  end
end
