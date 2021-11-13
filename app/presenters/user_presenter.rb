# ユーザー詳細 presenter
# todo UsersPresenterと共通部分は抜き出す
class UserPresenter
  def initialize(user)
    @user = user
  end

  def as_json
    return {} if @user.blank?

    {
      user: {
        id: @user.id,
        nickname: @user.nickname,
        email: @user.email,
        sex: User::SEX[@user.sex],
        birth_year: @user.birth_year,
        birth_month: @user.birth_month,
        birth_day: @user.birth_day,
        introduction: @user.introduction,
        # syukou: @user.syukou,
        # commitment: @user.commitment,
        tweet: @user.tweet,
        prefecture: prefecture
      },
      profile_images: profile_images,
      music_categories: music_categories,
      affected_musicians: affected_musicians,
      # sns_services: user_sns_services,
      active_dates: active_dates,
      instruments: InstrumentsPresenter.new(@user.instruments).as_json
    }
  end

  private

  def prefecture
    Prefecture.by_id(@user.prefecture_id)
              .pluck(:name)
              .first
  end

  def profile_images
    @user.user_profile_images
         .sort_by { |val| val[:position] }
         .map{ |n| Settings.image.host + n.image.current_path }
  end

  def music_categories
    ids = @user.user_to_music_categories.map(&:music_category_id)
    MusicCategory.by_id(ids)
                 .pluck(:name)
  end

  def affected_musicians
    ids = @user.user_to_affected_musicians
               .sort_by { |val| val[:position] }
               .pluck(:affected_musician_id)

    AffectedMusician.by_id(ids).pluck(:name)
  end

  def user_sns_services
    @user.user_sns_services.map do |sns_service|
      {
        type: UserSnsService::SNS[sns_service.sns_type],
        url: sns_service.url
      }
    end
  end

  def active_dates
    active_date_ids = @user.user_active_dates.pluck(:date).sort
    active_date_ids.map do |active_date_id|
      UserActiveDate::DATE[active_date_id]
    end
  end
end
