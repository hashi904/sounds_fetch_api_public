class AddColumnSnsService070901200 < ActiveRecord::Migration[6.1]
  def change
    add_column :user_sns_services, :url, :string
    add_column :user_sns_services, :sns_type, :integer
    # remove_column :user_sns_services, :sns_service_id
    # sns_serviceはmdropしたのでmigrateから除外する
    # drop_table :sns_services
  end
end
