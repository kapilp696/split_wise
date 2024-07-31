require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { create(:user) }
  let!(:expense) { create(:expense, user: user) }
  let!(:debt) { create(:debt, expense: expense, from_user: user, to_user: user) }

  before do
    sign_in user
  end

  describe 'GET #show' do
    before do
      get :show, params: { id: user.id }
    end

    it 'assigns the requested user to @user' do
      expect(assigns(:user)).to eq(user)
    end

    it 'assigns total_borrowed to @total_borrowed' do
      expect(assigns(:total_borrowed)).to eq(50.0)
    end

    it 'assigns total_lent to @total_lent' do
      expect(assigns(:total_lent)).to eq(50.0)
    end

    it 'assigns the user debts to @debts' do
      expect(assigns(:debts)).to eq(user.debts)
    end

    it 'assigns the user credits to @credits' do
      expect(assigns(:credits)).to eq(user.credits)
    end
  end

  describe 'POST #send_invite' do
    let(:recipient_email) { Faker::Internet.email }
    let(:mail) { double('Mail', deliver_now: true, subject: "#{user.email} wants to share bills with you on Splitwise!") }

    before do
      allow(InviteNotificationMailer).to receive(:invite_email).and_return(mail)
    end

    it 'sends an invite email' do
      post :send_invite, params: { email: recipient_email }
      expect(InviteNotificationMailer).to have_received(:invite_email).with(recipient_email, user)
      expect(mail.subject).to eq("#{user.email} wants to share bills with you on Splitwise!")
    end

    it 'redirects to the root path with a notice' do
      post :send_invite, params: { email: recipient_email }
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq('Invitation to join splitwise sent successfully')
    end
  end
end
