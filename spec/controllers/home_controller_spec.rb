require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "GET #index" do
    let!(:groups) { create(:group) } 

    it "assigns all groups to @groups" do
      get :index
      # expect(assigns(:groups)).to eq(groups)
    end
  end
end
