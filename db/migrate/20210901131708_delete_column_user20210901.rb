class DeleteColumnUser20210901 < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :syukou, :text
    remove_column :users, :commitment, :integer
  end
end
