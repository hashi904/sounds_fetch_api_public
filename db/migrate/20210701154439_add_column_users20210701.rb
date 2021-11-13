class AddColumnUsers20210701 < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :nickname, :string, null:false
    add_column :users, :sex, :integer, null:false
    add_column :users, :birth_year, :integer, null:false
    add_column :users, :birth_month, :integer, null:false
    add_column :users, :birth_day, :integer, null:false
    add_column :users, :introduction, :text, null:false
    add_column :users, :syukou, :text, null:false
    add_column :users, :commitment, :integer, null:false
    add_column :users, :authentication_flag, :integer, null:false
    add_column :users, :tweet, :text, null:false
    add_reference :users, :prefecture, foreign_key: true
  end
end
