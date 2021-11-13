class AddColumnRegistrationMails202108170835 < ActiveRecord::Migration[6.1]
  def change
    add_column :registration_mails, :token, :string, null:false
  end
end
