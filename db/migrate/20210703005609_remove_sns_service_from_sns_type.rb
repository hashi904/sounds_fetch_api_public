class RemoveSnsServiceFromSnsType < ActiveRecord::Migration[6.1]
  def change
    # sns_serviceはmdropしたのでmigrateから除外する
    # remove_column :sns_services, :sns_type
  end
end
