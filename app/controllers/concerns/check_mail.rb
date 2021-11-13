module CheckMail
  extend ActiveSupport::Concern

  def check_mail_from_token
    return render_unauthorized_json if params[:token].blank?
    if email.blank? && !RegistrationMail.able_to_sign_up_account(email).present?
      return render_unauthorized_json
    end
  end

  def check_registration_mail
    # note 同じメールで複数回送った時は最新のレコードを取り出す。
    @registration_mail = RegistrationMail.where(email: create_user_params['email']).first

    return render_unauthorized_json if !@registration_mail.present? ||
                                       @registration_mail.status == RegistrationMail::Status::ON
  end

  private

  def email
    @decoded_email = SoundsFetch::Cipher::SignUp::Base.decode(params[:token])
  end

  def render_unauthorized_json
    render json: { message: 'このメールアドレスは登録できません。' }, status: :unauthorized
  end
end
