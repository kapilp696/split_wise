require 'rails_helper'

RSpec.describe DebtsController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:group) { create(:group, user: user) }
  let(:debt) { create(:debt, group: group, from_user: other_user, to_user: user) }

  before do
    sign_in user 
  end

  describe "POST #settle" do
    it "updates the debt as settled" do
      post :settle, params: { id: debt.to_param }
      debt.reload
      expect(debt.settled).to be true
      expect(debt.amount).to eq(0.0)
    end

    it "redirects to the fallback location with a notice" do
      post :settle, params: { id: debt.to_param }
      expect(response).to redirect_to(user_path(user))
      expect(flash[:notice]).to eq('Debt was successfully settled.')
    end
  end
end
