class UserActiveDate < ApplicationRecord
  belongs_to :user, optional: true

  validates :date, presence: true, inclusion: { in: 0..3 }

  DATE =
    {
      0 => '土日',
      1 => '平日',
      2 => '不定期',
      3 => 'その他'
    }
  DATE_IN_HASH = [
    {id: 0, label: '土日' },
    {id: 1, label: '平日' },
    {id: 2, label: '不定期' },
    {id: 3, label: 'その他' },
  ]
end
