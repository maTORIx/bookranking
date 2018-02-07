class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.notice.subject
  #
  def notice

    mail to: "matorixmatrix@gmail.com", subject: "action mailer test"
  end
end
