class Api::V1::ChangePasswordController < Api::V1::ApiApplicationController

  before_action :authorized
  before_action :validate_change_password_params

  def confirmation
    begin
      @user = User.find_by(email: change_password_params[:email])

      if @user && @user.authenticate(change_password_params[:password])
        @user.update!(password: change_password_params[:change_password])

        return render json: {message: 'パスワードを変更しました。' }
      end

      password_error_message
    rescue => e
      password_error_message
    end
  end

  private

  def change_password_params
    params.require(:change_password).permit(:email, :password, :change_password, :change_password_confirm)
  end

  def validate_change_password_params
    validate_mail_params
    validate_password_params
    validate_password_comfirm
  end

  def validate_mail_params
    return user_error_message if change_password_params[:email].blank?
  end

  def validate_password_params
    return no_password_message if change_password_params[:password].blank? ||
                                  change_password_params[:change_password].blank?
  end

  def validate_password_comfirm
    return password_confirm_not_match_message if change_password_params[:change_password] !=
                                                  change_password_params[:change_password_confirm]
  end

  def user_error_message
    render json: { message: 'ページを再読み込みしてください' }, status: 400
  end

  def password_error_message
    render json: {message: '正しいパスワード入力してください' }, status: 400
  end

  def no_password_message
    render json: { message: 'パスワードが入力されていません' }, status: 400
  end

  def password_confirm_not_match_message
    render json: { message: '新しいパスワードが一致しません' }, status: 400
  end
end
