require 'rails_helper'

RSpec.describe InviteNotificationMailer, type: :mailer do
  describe 'invite_email' do
    let(:recipient_email) { Faker::Internet.email }
    let(:sender) { create(:user) }
    let(:mail) { InviteNotificationMailer.invite_email(recipient_email, sender) }

    it 'renders the headers' do
      expect(mail.subject).to eq("#{sender.email} wants to share bills with you on Splitwise!")
      expect(mail.to).to eq([recipient_email])
      expect(mail.from).to eq([sender.email])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(sender.email)
    end
  end
end
