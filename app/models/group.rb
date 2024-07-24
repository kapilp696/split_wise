class Group < ApplicationRecord
  has_many :group_memberships
  has_many :users, through: :group_memberships

  has_many :debts
  has_many :expenses, dependent: :destroy


  def calculate_debts
    debts = Hash.new(0)

    expenses.each do |expense|
      total_amount = expense.amount
      total_payers_amount = expense.expense_payers.sum(:amount)
      split_amount = (total_amount - total_payers_amount) / (users.count - expense.expense_payers.size)

      expense.expense_payers.each do |payer|
        amount_paid = payer.amount
        users.each do |user|
          next if user == payer.user

          debts[[payer.user, user]] += split_amount
          debts[[user, payer.user]] -= split_amount
        end
      end
    end

    debts
  end

  def settle_debts
    debts = calculate_debts

    debts.each do |(from_user, to_user), amount|
      next if amount <= 0

      Debt.create(
        group: self,
        from_user: from_user,
        to_user: to_user,
        amount: amount
      )
    end
  end
end
