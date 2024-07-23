class Expense < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :expense_payers
  has_many :payers, through: :expense_payers, source: :user
end
