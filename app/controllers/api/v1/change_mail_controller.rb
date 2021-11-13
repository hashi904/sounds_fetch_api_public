class Api::V1::ChangeMailController < Api::V1::ApiApplicationController
  include CheckMail

  before_action :authorized, only: [:index, :create]
  before_action :validate_change_mail_params, only: [:create]
  before_action :validate_unique_email, only: [:create]
  before_action :check_mail_from_token, only: [:confirmation]

  def index
    if logged_in_user.present?
      return render json: {email: @user.email}
    end

    return render json: {message: 'ユーザーが不正です。ログインし直してください'}
  end

  def create
    @user = User.find_by(email: change_mail_params[:email])
    token = SoundsFetch::Cipher::SignUp::Base.encode(change_mail_params[:email])
    change_email = ChangeMail.new(
                                  email: change_mail_params[:email], 
                                  change_email: change_mail_params[:change_email], 
                                  status: ChangeMail::Status::OFF, 
                                  token: token
                                 )

    if @user && @user.authenticate(change_mail_params[:password]) && change_email.save
      ChangeMailMailer.send_change_mail(@user, change_mail_params[:change_email], token).deliver

      return render json: {message: 'メールを送信しました。ご確認ください' }
    end

    render json: {message: 'パスワードが間違っています。' }, status: 400
  end

  def confirmation
    begin
      @user = User.find_by(email: @decoded_email)
      @change_mail = ChangeMail.changeable_mail_account(@decoded_email).first

      if @user && @change_mail
        @user.update!(email: @change_mail.change_email)
        @change_mail.update!(status: ChangeMail::Status::ON)

        return render json: {message: 'メールアドレスを変更しました。' }
      end

      render json: {message: '不正なユーザーです。ログインし直してください' }, status: 400
    rescue => e
      render json: {message: '問題が発生しました。もう一度やり直してください' }, status: 400
    end
  end

  private

  def validate_change_mail_params
    if change_mail_params[:email].blank? || change_mail_params[:change_email].blank?
      return render json: { message: 'メールアドレスが入力されていません' }, status: 400
    end
  end

  def validate_unique_email
    if change_mail_params[:email] == change_mail_params[:change_email]
      return render json: { message: '新しいメールアドレスの入力値が不正です。' }, status: 400
    end
  end

  def change_mail_params
    params.require(:change_mail).permit(:email, :change_email, :password)
  end
end
