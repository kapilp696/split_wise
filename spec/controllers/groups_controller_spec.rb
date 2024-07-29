require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  let(:user) { create(:user) }
  let(:group) { create(:group, user: user) }
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
      group = create(:group, user: user)
      get :index
      expect(assigns(:groups)).to eq([group])
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

      it "redirects to the groups list" do
        post :create, params: { group: attributes_for(:group) }
        expect(response).to redirect_to(groups_path)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e., to display the 'new' template)" do
        post :create, params: { group: attributes_for(:group, name: nil) }
        expect(response).to be_successful
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
      group = create(:group, user: user)
      expect {
        delete :destroy, params: { id: group.to_param }
      }.to change(Group, :count).by(-1)
    end

    it "redirects to the groups list" do
      delete :destroy, params: { id: group.to_param }
      expect(response).to redirect_to(groups_url)
    end
  end

  describe "GET #manage_members" do
    it "returns a success response" do
      get :manage_members, params: { id: group.to_param }
      expect(response).to be_successful
    end

    it "assigns all users to @users" do
      user2 = create(:user)
      get :manage_members, params: { id: group.to_param }
      expect(assigns(:users)).to include(user, user2)
    end
  end

  describe "POST #add_members" do
    it "adds members to the group" do
      new_user = create(:user)
      expect {
        post :add_members, params: { id: group.to_param, user_ids: [new_user.id] }
      }.to change(group.group_memberships, :count).by(1)
    end

    it "redirects to manage_members page with notice" do
      post :add_members, params: { id: group.to_param, user_ids: [create(:user).id] }
      expect(response).to redirect_to(manage_members_group_path(group))
      expect(flash[:notice]).to eq('Members were successfully added.')
    end
  end

  describe "DELETE #remove_member" do
    it "removes the member from the group" do
      membership = group.group_memberships.create(user: user)
      expect {
        delete :remove_member, params: { id: group.to_param, user_id: user.to_param }
      }.to change(group.group_memberships, :count).by(-1)
    end

    it "redirects to manage_members page with notice" do
      group.group_memberships.create(user: user)
      delete :remove_member, params: { id: group.to_param, user_id: user.to_param }
      expect(response).to redirect_to(manage_members_group_path(group))
      expect(flash[:notice]).to eq('Member was successfully removed.')
    end
  end
end
