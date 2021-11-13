class ChangeMailMailer < ApplicationMailer
  def send_change_mail(user, email, token)
    @user = user
    @token = token

    mail(
      from: Settings.send_grid.mail,
      subject: '【SoundsFetch】メールアドレス変更の確認',
      to: email
    ) do |format|
      format.text
    end
  end
end
