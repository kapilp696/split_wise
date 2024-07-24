class ExpensesController < ApplicationController
  before_action :set_group
  before_action :set_expense, only: %i[show edit update destroy]

  def index
    @expenses = @group.expenses
  end

  def show; end

  def new
    @expense = @group.expenses.build
    @expense.expense_payers.build
  end

  def create
    @expense = @group.expenses.build(expense_params)

    if @expense.save
      process_payments(@expense, params[:expense_payers])
      redirect_to group_expenses_path(@group), notice: 'Expense was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @expense.update(expense_params)
      redirect_to group_expense_path(@group, @expense), notice: 'Expense was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @expense.destroy
    redirect_to group_expenses_path(@group), notice: 'Expense was successfully destroyed.'
  end

  private

  def set_group
    @group = Group.find(params[:group_id]) if params[:group_id]
  end

  def set_expense
    @expense = @group.expenses.find(params[:id])
  end

  def expense_params
    # params.require(:expense).permit(:description, :amount)
    params.require(:expense).permit(:amount, :description, :group_id, expense_payers_attributes: [:id, :user_id, :amount])
  end

  def create_debts
    total_amount = @expense.amount
    paid_amount = @expense.expense_payers.sum(&:amount)
    debt_amount = total_amount - paid_amount

    # Get all users involved in the expense
    involved_users = @expense.expense_payers.map(&:user)

    # Calculate equal share for those who haven't paid
    remaining_users = @group.present? ? @group.users - involved_users : User.all - involved_users
    share_per_user = debt_amount / remaining_users.count

    remaining_users.each do |user|
      Debt.create!(
        group: @expense.group,
        expense: @expense,
        from_user: user,
        to_user: current_user,
        amount: share_per_user
      )
    end
  end

  def process_payments(expense, payers_params)
    payers_params.each do |payer|
      ExpensePayer.create!(
        user_id: payer[:user_id],
        expense_id: expense.id,
        amount: payer[:amount].to_d
      )
    end
  end
end
