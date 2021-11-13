class AddColumnSnsService07020930 < ActiveRecord::Migration[6.1]
  def change
    # sns_serviceはmdropしたのでmigrateから除外する
    # add_column :sns_services, :sns_type, :integer, null:false
  end
end
