# Preview all emails at http://localhost:3000/rails/mailers/invite_notification_mailer
class InviteNotificationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/invite_notification_mailer/invite_email
  def invite_email
    InviteNotificationMailer.invite_email
  end

end
