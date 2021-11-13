class CreateUserProfileImages < ActiveRecord::Migration[6.1]
  def change
    create_table :user_profile_images do |t|
      t.string :image, null:false
      t.integer :position, null:false
      t.references :user, foreign_key: true
      t.timestamps

    end
  end
end
