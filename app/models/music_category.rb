class MusicCategory < ApplicationRecord
  # relation
  has_many :users, through: :user_to_music_categories
  has_many :user_to_music_categories

  # validation
  validates :name, presence: true

  # scope
  scope :by_id, ->(music_category_id) { where id: music_category_id }
end
