class UserProfileImage < ApplicationRecord
  # relation
  belongs_to :user, optional: true

  # setting for carrierwave
  mount_uploader :image, UserProfileImageUploader

  # scope
  scope :own_images, ->(id, user_id) { where(id: id).where(user_id: user_id) }

  # validation
  validates :image, presence: true
  validates :position, presence: true

  def local_dir_path
    "#{Settings.aws.s3.backet_name}/images/users/profile_images/#{user_id}/#{position}"
  end
end
