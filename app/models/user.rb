class User < ApplicationRecord
  # relation
  has_many :user_profile_images, dependent: :destroy
  has_many :user_active_dates, dependent: :destroy
  has_one :prefecture
  has_many :music_categories, through: :user_to_music_categories
  has_many :user_to_music_categories, dependent: :destroy
  has_many :affected_musicians, through: :user_to_affected_musicians
  has_many :user_to_affected_musicians, dependent: :destroy
  has_many :user_sns_services, dependent: :destroy
  has_many :instruments, dependent: :destroy
  has_many :instrument_to_special_skills, through: :instruments, dependent: :destroy
  has_many :instrument_to_equipments, through: :instruments, dependent: :destroy

  accepts_nested_attributes_for :user_active_dates
  accepts_nested_attributes_for :user_to_music_categories
  accepts_nested_attributes_for :user_sns_services
  accepts_nested_attributes_for :instruments
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  # validates
  # todo add validates FK
  validates :nickname, presence: true, length: { maximum: 9 }
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :sex, presence: true, inclusion: { in: 0..2 }
  validates :birth_year, presence: true, inclusion: { in: 1900..Time.now.year }
  validates :birth_month, presence: true, inclusion: { in: 1..12 }
  validates :birth_day, presence: true, inclusion: { in: 1..31 }
  validates :introduction, presence: true, length: { maximum: 800 }
  # validates :syukou, presence: true, length: { maximum: 20 }
  # validates :commitment, presence: true, inclusion: { in: 1..5 }
  validates :authentication_flag, presence: true, inclusion: { in: 0..1 }
  validates :tweet, presence: true, length: { in: 6..20 }
  # userが0の状態でrails db:seedを実行する場合はコメントアウトすること
  validates :prefecture_id, presence: true
  
  # password encryption
  # password validation
  has_secure_password

  # scope
  scope :by_id, ->(user_id) { where id: user_id }

  SEX = { 0 => '男性', 1 => '女性', 2 => 'その他' }

  module AuthenticationFlag
    OFF = 0
    ON = 1
  end

  class << self
    def fetch_detail(user_id)
      by_id(user_id)
      .includes([
        :user_profile_images,
        :user_to_music_categories,
        :user_active_dates,
        instruments: [
          :instrument_to_live_experiences,
          :instrument_to_equipments,
          :instrument_to_special_skills
        ]
      ])
      .first
    end

    def format_pagenation(page, users_per_page)
      includes([
        :user_profile_images,
        :user_to_music_categories,
        :instruments
      ])
      .page(page)
      .per(users_per_page)
    end

    def search_instrument_type(instrument_type_ids)
      joins(:instruments).where(instruments: { instrument_type: instrument_type_ids })
    end
  end

  def bulk_upsert_user_to_music_categories!(music_categories)
    ::Users::BulkUpsertUserToMusicCategoryService
      .new(self.id, music_categories, self.errors)
      .call
  end

  def bulk_upsert_user_to_affected_musicians!(affected_musicians)
    ::Users::BulkUpsertUserToAffectedMusiciansService
      .new(self.id, affected_musicians, self.errors)
      .call
  end

  def search_music_category(instrument_type_ids)
    joins(:instruments)
      .where(instruments: {instrument_type_id: instrument_type_ids})
  end
end
