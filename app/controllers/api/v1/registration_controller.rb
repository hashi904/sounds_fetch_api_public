# 登録関連のコントローラ
class Api::V1::RegistrationController < Api::V1::ApiApplicationController
  include CheckMail

  before_action -> { parse_json_to_hash(:registration) }, only: [:create, :update]
  before_action :authorized, only: [:edit, :update, :destroy]
  before_action :check_mail_from_token, only: [:index, :create]
  before_action :check_registration_mail, only: [:create]

  def authenticate_mail
    ## encodeしたときの値をチェック
    email = authenticate_mail_params[:email]
    return render json: {message: 'メールアドレスが入力されていません' }, status: 400 if email.blank?

    token =
      SoundsFetch::Cipher::SignUp::Base.encode(email)

    registration_mail = RegistrationMail.new(email: email, status: RegistrationMail::Status::OFF, token: token)

    if registration_mail.save
      RegistrationMailer.send_sign_up_mail(email, token).deliver
      return render json: {message: 'メールを送信しました。'}
    end

    render json: {message: 'メールを送信できませんでした。しばらく経ってからやる直してください'}, status: 400
  end

  def sign_in
    @user = User.find_by(email: sign_in_params[:email])
    if @user && @user.authenticate(sign_in_params[:password])
      token = encode_token({ user_id: user_id})
      render json: { user_id: @user.id, user: @user.email, token: token, message: 'ログインに成功しました。' }
    else
      render json: { message: 'メールアドレスまたはパスワードが間違っています。' }, status: :unauthorized
    end
  end

  def index
    render json: { registration: selector, email: @decoded_email }
  end

  def edit
    @user = User.fetch_detail(params[:id])
    return render_bad_user unless @user.present? && @user.id == logged_in_user_id

    render json: { registration: selector, user: Registration::UpdateUserPresenter.new(@user).as_json}
  end

  def create
    @user = User.new(create_user_params)
    insert_user

    if @user.errors.blank? && @user.valid?
      token = encode_token({ user_id: user_id })
      render json: { user_id: @user.id, user: @user.email, token: token, message: 'ユーザーの新規登録が完了しました。' }
    else
      render json: { error: error_message}, status: 409
    end
  end

  def update
    @user = User.find(params[:id])
    if logged_in_user_id.to_s == params[:id]
      update_user
    else
      @user.errors.add(:base, '不正なユーザーです。ログインし直してください')
    end

    if @user.errors.blank? && @user.valid?
      render json: { message: 'ユーザーの更新が完了しました。' }
    else
      render json: { error: error_message}, status: 409
    end
  end

  def destroy
    @user = User.find(params[:id])

    if logged_in_user_id.to_s == params[:id]
      @user.destroy
    else
      @user.errors.add(:base, '不正なユーザーです。ログインし直してください')
    end

    if @user.errors.blank?
      render json: { message: '退会処理は完了しました。' }
    else
      render json: { error: error_message}, status: 409
    end
  end

  private

  def authenticate_mail_params
    params.require(:registration).permit(:email)
  end

  def sign_in_params
    params.require(:registration).permit(:email, :password)
  end

  def sign_up_params
    params.require(:registration).permit(
      user: [
        :nickname,
        :email,
        :password,
        :sex,
        :birth_year,
        :birth_month,
        :birth_day,
        :introduction,
        # :syukou,
        # :commitment,
        :tweet,
        :prefecture_id,
        user_active_dates_attributes: [:date]
        # user_sns_services_attributes: [:url, :sns_type],
      ],
      music_categories: [:music_category_id, :position],
      # affected_musicians: [:musician_id, :position],
      instruments: [
        :instrument_type_id,
        :experience,
        :skill_level,
        :position,
        live_experiences: [:live_experience_id]
        # special_skills: [:special_skill_id],
        # equipments: [:equipment_id]
      ]
    )
  end

  def update_params
    params.require(:registration).permit(
      user: [
        :introduction,
        # :syukou,
        # :commitment,
        :prefecture_id,
        :tweet,
        user_active_dates_attributes: [:id, :date]
        # user_sns_services_attributes: [:id, :url, :sns_type]
      ],
      music_categories: [:music_category_id, :position],
      # affected_musicians: [:id, :musician_id, :position],
      instruments: [
        :id,
        :instrument_type_id,
        :experience,
        :skill_level,
        :position,
        live_experiences: [:id, :live_experience_id],
        # special_skills: [:id, :special_skill_id],
        # equipments: [:id, :equipment_id]
      ]
    )
  end

  def create_user_params
    sign_up_params[:user].merge({
      authentication_flag: User::AuthenticationFlag::OFF,
      instruments_attributes: instruments_attributes(sign_up_params[:instruments])
    })
  end

  def update_user_params
    params = update_params[:user]

    if update_params[:instruments].present?
      params.merge!({
        instruments_attributes: instruments_attributes(update_params[:instruments])
      })
    end

    params
  end

  def insert_user
    begin
      ActiveRecord::Base.transaction do
        @user.save!
        Users::BulkInsertUserToMusicCategory.new(@user, sign_up_params[:music_categories], :create).call
        bulk_upsert_instrument_join_table(sign_up_params[:instruments], 'create')
        UserProfileImage.new(image: params[:image], user_id: @user.id, position: 1).save!
        @registration_mail.update!(status: RegistrationMail::Status::ON)
        # @user.bulk_upsert_user_to_affected_musicians!(sign_up_params[:affected_musicians])
      end
    rescue => e
      if @user.errors.blank?
        @user.errors.add(:base, '問題が発生しました、しばらく経ってからもう一度やり直してください。')
      end
    end
  end

  def update_user
    begin
      ActiveRecord::Base.transaction do
        @user.update!(update_user_params)
        Users::BulkInsertUserToMusicCategory.new(@user, update_params[:music_categories], :update).call
        update_instrument_join_table(update_params[:instruments])
        if params[:image].present?
          @image = UserProfileImage.own_images(@user.user_profile_images[0].id, @user.id).first
          @image.update!({image: params[:image]})
        end
        # @user.bulk_upsert_user_to_affected_musicians!(update_params[:affected_musicians])
      end
    rescue => e
      if @user.errors.blank?
        # サーバーエラー
        @user.errors.add(:base, '問題が発生しました、しばらく経ってからもう一度やり直してください。')
      end
    end
  end

  def update_instrument_join_table(instruments_params)
    return if instruments_params.blank?

    bulk_upsert_instrument_join_table(instruments_params, 'update')
  end

  # 中間テーブルに保存する値以外のparamsを作成する
  def instruments_attributes(instruments_params)
    return if instruments_params.blank?

    instruments_params.map do |instrument|
      {
        id: instrument[:id] || nil, # update用
        instrument_type_id: instrument[:instrument_type_id],
        experience: instrument[:experience],
        skill_level: instrument[:skill_level],
        position: instrument[:position]
      }
    end
  end

  def bulk_upsert_instrument_join_table(instruments_params, mode)
    @user.instruments.each_with_index do |instrument, idx|
      instrument.bulk_upsert_join_table(instruments_params[idx], base_errors, mode)
    end
  end

  def selector
    Registration::SelectorPresenter.new.as_json
  end

  def base_errors
    @user.errors
  end

  def error_message
    # todo validationをsave前の全てのparamsに実施して不正な項目を全て表示させる
    return @user.errors.full_messages if @user.errors.any?

    '入力に不正があります。'
  end
end
