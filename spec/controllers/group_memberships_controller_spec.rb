require 'rails_helper'

RSpec.describe GroupMembershipsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:group) { create(:group) }
  before(:each) do
    create(:group_membership, user: user, group: group)
  end
  before do
    sign_in user
  end

  describe "DELETE #destroy" do
    it "destroys the requested group membership" do
      expect {
        delete :destroy, params: { group_id: group.id, id: user.id}
      }.to change(GroupMembership, :count).by(-1)
    end

    it "redirects to the root" do
      delete :destroy, params: { group_id: group.id, id: user.id }
      expect(response).to redirect_to(edit_group_path(group))
    end
  end
end
