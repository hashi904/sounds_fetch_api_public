# 更新画面用のユーザープレゼンター

module Registration
  class UpdateUserPresenter
    def initialize(user)
      @user = user
    end

    def as_json
      return {} if @user.blank?

      {
        user: {
          id: @user.id,
          introduction: @user.introduction,
          tweet: @user.tweet,
          prefecture: prefecture,
        },
        profile_images: profile_images,
        music_categories: music_categories,
        active_dates: active_dates,
        instruments: UpdateInstrumentsPresenter.new(@user.instruments).as_json
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
           .sort_by { |val| val[:position] }.map do |record|
        { id: record.id, image: Settings.image.host + record.image.current_path }
      end
    end

    def music_categories
      user_to_music_categories =
        @user.user_to_music_categories
             .select(:id, :music_category_id, :position)

      user_to_music_categories.map do |record|
        {
          user_to_category_id: record.id,
          id: record.music_category_id,
          name: MusicCategory.by_id(record.music_category_id).first.name,
          position: record.position
        }
      end
    end

    def active_dates
      dates = @user.user_active_dates.select(:id, :date).sort

      dates
    end
  end  
end
