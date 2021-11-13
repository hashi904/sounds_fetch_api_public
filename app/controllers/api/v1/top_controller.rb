class Api::V1::TopController < Api::V1::ApiApplicationController
  # topページに表示するユーザー設定
  # toppageに表示するユーザーは新規登録したユーザー3人
  PAGE = 1
  USERS_PER_TOP_PAGE = 3

  def index
    json = UsersPresenter.new(top_users).as_json
    render json: { users: json }
  end

  private

  def top_users
    User.all
        .format_pagenation(PAGE, USERS_PER_TOP_PAGE)
  end
end
