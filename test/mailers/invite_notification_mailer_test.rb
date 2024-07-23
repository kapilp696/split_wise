require "test_helper"

class InviteNotificationMailerTest < ActionMailer::TestCase
  test "invite_email" do
    mail = InviteNotificationMailer.invite_email
    assert_equal "Invite email", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
