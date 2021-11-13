class UserSnsService < ApplicationRecord
  belongs_to :user, optional: true

  validates :url, presence: true
  validates :sns_type, presence: true, inclusion: { in: 0..6 }

  SNS = {
    0 => 'YouTube',
    1 => 'Twitter',
    2 => 'EGGS',
    3 => 'FaceBook',
    4 => 'Instagram',
    5 => 'SYNCROOM',
    6 => 'Tik Tok'
  }

  SNS_JSON_DATA = [
    { id: 0, name: 'YouTube' },
    { id: 1, name: 'Twitter' },
    { id: 2, name: 'EGGS' },
    { id: 3, name: 'FaceBook' },
    { id: 4, name: 'Instagram' },
    { id: 5, name: 'SYNCROOM' },
    { id: 6, name: 'Tik Tok' }
  ]
end
