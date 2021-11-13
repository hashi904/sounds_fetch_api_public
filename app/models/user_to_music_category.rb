class UserToMusicCategory < ApplicationRecord
  # relations
  belongs_to :user, optional: true
  belongs_to :music_category

  # validates
  validates :position, presence: true
  validates :user_id, presence: true
  validates :music_category_id, presence: true
end
