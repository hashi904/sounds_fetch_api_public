class AddAndDeleteColumnUserToCategory2021070521 < ActiveRecord::Migration[6.1]
  def change
    add_reference :user_to_music_categories, :music_category, foreign_key: true
    remove_column :user_to_music_categories, :prefecture_id
  end
end
