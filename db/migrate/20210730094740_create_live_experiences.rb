class CreateLiveExperiences < ActiveRecord::Migration[6.1]
  def change
    create_table :live_experiences do |t|
      t.string :type, null:false

      t.timestamps
    end
  end
end
