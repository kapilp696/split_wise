class ExpensesController < ApplicationController
  before_action :set_group
  before_action :set_expense, only: %i[show edit update destroy]

  def index
    @expenses = @group.expenses
  end

  def show; end

  def new
    @expense = @group.expenses.build
    @users = @group.users
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
    @group = Group.find(params[:group_id])
  end

  def set_expense
    @expense = @group.expenses.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:description, :amount)
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
