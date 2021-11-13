class RegistrationMailer < ApplicationMailer
  def send_sign_up_mail(email, token)
    @token = token

    mail(
      from: Settings.send_grid.mail,
      subject: '【SoundsFetch】仮登録の完了',
      to: email
    ) do |format|
      format.text
    end
  end
end
