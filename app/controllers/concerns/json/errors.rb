module Json
  # エラーメッセージをjsonで返すメソッド集
  module Errors
    extend ActiveSupport::Concern

    def render_bad_user(message = '不正なユーザーです。ログインし直してください。')
      render json: { message: message }, status: :bad_request
    end
  end
end
