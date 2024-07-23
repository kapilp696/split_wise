class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :group_memberships
  has_many :groups, through: :group_memberships

  # has_many :expenses
  has_many :debts, foreign_key: :from_user_id
  has_many :credits, class_name: 'Debt', foreign_key: :to_user_id

  has_many :expense_payers
  has_many :expenses, through: :expense_payers

  def total_borrowed
    debts.where(settled: false).sum(:amount)
  end

  def total_lent
    credits.where(settled: false).sum(:amount)
  end
end
