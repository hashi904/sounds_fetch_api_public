class AddColumnUserToAffectedMusician070901200 < ActiveRecord::Migration[6.1]
  def change
    add_column :user_to_affected_musicians, :position, :integer
  end
end
