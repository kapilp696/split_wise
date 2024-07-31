require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:group) { create(:group) }
  before(:each) do
    create(:group_membership, user: user, group: group)
  end
  before do
    sign_in user
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end

    it "assigns the user's groups to @groups" do
      groups = user.groups
      get :index
      expect(assigns(:groups)).to eq(groups)
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: group.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end

    it "assigns a new group as @group" do
      get :new
      expect(assigns(:group)).to be_a_new(Group)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Group" do
        expect {
          post :create, params: { group: attributes_for(:group) }
        }.to change(Group, :count).by(1)
      end

      it "redirects to the group show" do
        post :create, params: { group: attributes_for(:group) }
        expect(response.location).to match(/\/groups\/\d+/)
      end
    end

    context "with invalid params" do
      it "returns a failure response (i.e., to display the 'new' template)" do
        post :create, params: { group: attributes_for(:group, name: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: { id: group.to_param }
      expect(response).to be_successful
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { name: 'New Group Name' }
      }

      it "updates the requested group" do
        put :update, params: { id: group.to_param, group: new_attributes }
        group.reload
        expect(group.name).to eq('New Group Name')
      end

      it "redirects to the group" do
        put :update, params: { id: group.to_param, group: new_attributes }
        expect(response).to redirect_to(group)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e., to display the 'edit' template)" do
        put :update, params: { id: group.to_param, group: attributes_for(:group, name: nil) }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested group" do
      group = create(:group)
      expect {
        delete :destroy, params: { id: group.to_param }
      }.to change(Group, :count).by(-1)
    end

    it "redirects to the root" do
      delete :destroy, params: { id: group.to_param }
      expect(response).to redirect_to(root_path)
    end
  end
end
