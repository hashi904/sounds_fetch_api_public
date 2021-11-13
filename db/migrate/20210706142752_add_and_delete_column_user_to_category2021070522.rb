class AddAndDeleteColumnUserToCategory2021070522 < ActiveRecord::Migration[6.1]
  def change
    add_column :user_to_music_categories, :position, :integer, null:false
  end
end
