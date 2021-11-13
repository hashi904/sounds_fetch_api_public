class CreateChangeMails < ActiveRecord::Migration[6.1]
  def change
    create_table :change_mails do |t|
      t.string :email, null: false
      t.string :change_email, null: false
      t.integer :status, null:false
      t.string :token, null:false
      t.timestamps
    end
  end
end
