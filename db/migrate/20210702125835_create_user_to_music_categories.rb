class CreateUserToMusicCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :user_to_music_categories do |t|
      t.references :prefecture, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
