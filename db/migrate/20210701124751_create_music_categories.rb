class CreateMusicCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :music_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
