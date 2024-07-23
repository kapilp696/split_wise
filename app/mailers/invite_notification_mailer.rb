class InviteNotificationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invite_notification_mailer.invite_email.subject
  #
  def invite_email
    mail to: "to@example.org", subject: "#{current_user.email} wants to share bills with you on Splitwise!"
  end
end
