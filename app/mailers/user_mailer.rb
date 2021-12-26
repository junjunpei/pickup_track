class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_password_email.subject
  #
  def reset_password_email(user)
    @user = User.find(user.id)
    @url = "#{Settings.default_url_options.protocol}#{Settings.default_url_options.host}/reset_password/path?id=#{@user.reset_password_token}"
    mail(to: user.email, subject: 'パスワード再設定のご案内')
  end
end
