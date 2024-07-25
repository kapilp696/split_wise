class ExpensesController < ApplicationController
  before_action :set_group
  before_action :set_expense, only: %i[show edit update destroy]

  def index
    @expenses = @group.expenses
  end

  def show
  end

  def new
    @expense = @group.expenses.build
  end

  def create
    @expense = @group.expenses.build(expense_params)

    if @expense.save
      handle_debts(@expense)
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
    params.require(:expense).permit(:amount, :description, :user_id)
  end


  def handle_debts(expense)
    users = expense.group.users
    share_per_user = expense.amount/users.count

    users.each do |user|
      next if user==expense.user
      debt = Debt.find_by(group: expense.group, from_user: user, to_user: expense.user)
      if debt
        if debt.amount > 0 && debt.amount>=share_per_user
          debt.amount -= share_per_user
        end
        debt.expense_id=expense.id
        debt.save!
      else
        debt = Debt.new(group: expense.group, from_user: user, to_user: expense.user)
        debt.amount += share_per_user
        debt.expense_id=expense.id
        debt.save!
      end
    end
  end
end
