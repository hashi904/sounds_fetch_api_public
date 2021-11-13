class CreateUserActiveDates < ActiveRecord::Migration[6.1]
  def change
    create_table :user_active_dates do |t|
      t.integer :date, null:false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
