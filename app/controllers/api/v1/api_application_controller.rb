# api v1 ApplicationController
class Api::V1::ApiApplicationController < ApplicationController
  # before_action :authorized
  # todo error handling

  SECRET_KEY_BASE = Settings.key_base

  def encode_token(payload)
    JWT.encode(exp_payload(payload), SECRET_KEY_BASE, 'HS256')
  end

  def logged_in_user
    if decoded_token
      @user = User.find_by(id: logged_in_user_id)
    end
  end

  def logged_in_user_id
    decoded_token[0]['data']['user_id']
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized
    render json: { message: 'ログインしてください。' }, status: :unauthorized unless logged_in?
  end

  private

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      # header: { 'Authorization': 'Bearer <token>' }
    end
    begin
      JWT.decode(token, SECRET_KEY_BASE, true, algorithm: 'HS256')
    rescue JWT::DecodeError
      nil
    rescue JWT::ExpiredSignature
      nil
    end
  end

  def auth_header
    # { Authorization: 'Bearer <token>' }
    request.headers['Authorization']
  end

  def exp_payload(payload)
    # 60 minutes
    exp = Time.now.to_i + 60 * 60
    { data: payload, exp: exp }
  end
end
