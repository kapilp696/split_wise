class Group < ApplicationRecord
  has_many :group_memberships, dependent: :destroy
  has_many :users, through: :group_memberships

  has_many :debts
  has_many :expenses, dependent: :destroy

  accepts_nested_attributes_for :group_memberships, allow_destroy: true

  def settle_debts
    debts = current_user.debts

    debts.each do |debt|
      # (from_user, to_user), amount
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
