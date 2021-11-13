class CreateRegistrationMails < ActiveRecord::Migration[6.1]
  def change
    create_table :registration_mails do |t|
      t.string :email, null: false
      t.integer :status, null:false
      t.timestamps
    end
  end
end
