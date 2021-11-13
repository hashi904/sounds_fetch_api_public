class CreateAffectedMusicians < ActiveRecord::Migration[6.1]
  def change
    create_table :affected_musicians do |t|
      t.string :name, null:false
      t.timestamps
    end
  end
end
