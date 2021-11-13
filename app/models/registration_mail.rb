class RegistrationMail < ApplicationRecord

  # validate
  validates :email, presence: true
  validates :token, presence: true
  validates :status, presence: true

  # scope
  scope :able_to_sign_up_account, ->(email) { where(email: email).where(status: Status::OFF) }
  scope :by_email, ->(email) { where(email: email) }

  # 登録済みステータス
  module Status
    OFF = 0
    ON = 1
  end
end
