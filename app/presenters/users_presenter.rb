# ユーザー一覧 presenter
class UsersPresenter
  def initialize(users)
    @users = users
  end

  def as_json
    return [] if @users.blank?

    @users.map do |user|
      {
        id: user.id,
        nickname: user.nickname,
        user_profile_images: profile_images(user),
        sex: User::SEX[user.sex],
        prefecture: prefecture(user.prefecture_id),
        tweet: user.tweet,
        instruments: InstrumentPresenter.new(user.instruments).as_json,
        music_categories: music_categories(user.user_to_music_categories)
      }
    end
  end

  private

  def profile_images(user)
    user.user_profile_images
        .sort_by { |val| val[:position] }
        .map{ |n| Settings.image.host + n.image.current_path }
  end

  def prefecture(prefecture_id)
    Prefecture.by_id(prefecture_id)
              .pluck(:name)
              .first
  end

  def music_categories(music_category_ids)
    ids = music_category_ids.map(&:music_category_id)
    MusicCategory.by_id(ids)
                 .pluck(:name)
  end
end
