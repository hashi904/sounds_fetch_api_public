class CreateUserToAffectedMusicians < ActiveRecord::Migration[6.1]
  def change
    create_table :user_to_affected_musicians do |t|
      t.references :user, foreign_key: true
      t.references :affected_musician, foreign_key: true
      t.timestamps
    end
  end
end
