class AddColumnSnsService07020926 < ActiveRecord::Migration[6.1]
  def change
    # sns_serviceはmdropしたのでmigrateから除外する
    # add_column :sns_services, :sns_type, :string, null:false
  end
end
