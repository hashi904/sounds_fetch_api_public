class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  include Json::Errors
  include Common::ParseJson

  # 1ページあたりに表示するユーザー数の設定
  USERS_PER_PAGE = 9

  def user_id
    @user.id || nil
  end
end
