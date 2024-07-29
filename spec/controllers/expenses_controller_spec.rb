require 'rails_helper'

RSpec.describe ExpensesController, type: :controller do
  let(:user) { create(:user) }
  let(:group) { create(:group, user: user) }
  let(:expense) { create(:expense, group: group, user: user) }

  before do
    sign_in user  # Assuming Devise for authentication
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: { group_id: group.id }
      expect(response).to be_successful
    end

    it "assigns the group's expenses to @expenses" do
      get :index, params: { group_id: group.id }
      expect(assigns(:expenses)).to include(expense)
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { group_id: group.id, id: expense.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: { group_id: group.id }
      expect(response).to be_successful
    end

    it "assigns a new expense as @expense" do
      get :new, params: { group_id: group.id }
      expect(assigns(:expense)).to be_a_new(Expense)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Expense" do
        expect {
          post :create, params: { group_id: group.id, expense: attributes_for(:expense, user_id: user.id) }
        }.to change(Expense, :count).by(1)
      end

      it "redirects to the group's expenses list" do
        post :create, params: { group_id: group.id, expense: attributes_for(:expense, user_id: user.id) }
        expect(response).to redirect_to(group_expenses_path(group))
      end

      it "handles debts correctly" do
        allow_any_instance_of(ExpensesController).to receive(:handle_debts).and_call_original
        post :create, params: { group_id: group.id, expense: attributes_for(:expense, user_id: user.id) }
        expect_any_instance_of(ExpensesController).to have_received(:handle_debts)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e., to display the 'new' template)" do
        post :create, params: { group_id: group.id, expense: attributes_for(:expense, amount: nil) }
        expect(response).to be_successful
      end
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: { group_id: group.id, id: expense.to_param }
      expect(response).to be_successful
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { amount: 200 }
      }

      it "updates the requested expense" do
        put :update, params: { group_id: group.id, id: expense.to_param, expense: new_attributes }
        expense.reload
        expect(expense.amount).to eq(200)
      end

      it "redirects to the expense" do
        put :update, params: { group_id: group.id, id: expense.to_param, expense: new_attributes }
        expect(response).to redirect_to(group_expense_path(group, expense))
      end

      it "handles update debts correctly" do
        allow_any_instance_of(ExpensesController).to receive(:handle_update_debts).and_call_original
        put :update, params: { group_id: group.id, id: expense.to_param, expense: new_attributes }
        expect_any_instance_of(ExpensesController).to have_received(:handle_update_debts)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e., to display the 'edit' template)" do
        put :update, params: { group_id: group.id, id: expense.to_param, expense: { amount: nil } }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested expense" do
      expense = create(:expense, group: group, user: user)
      expect {
        delete :destroy, params: { group_id: group.id, id: expense.to_param }
      }.to change(Expense, :count).by(-1)
    end

    it "redirects to the group's expenses list" do
      delete :destroy, params: { group_id: group.id, id: expense.to_param }
      expect(response).to redirect_to(group_expenses_path(group))
    end
  end
end
