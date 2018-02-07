class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.email_confirm.subject
  #
  def email_confirm(user)
    @user = user
    mail to: @user.email, subject: "Bookranking Email Confirm"
  end
end
