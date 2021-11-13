class CreateUserSnsServices < ActiveRecord::Migration[6.1]
  def change
    create_table :user_sns_services do |t|
      # sns_serviceはmdropしたのでmigrateから除外する
      # t.references :sns_service, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
