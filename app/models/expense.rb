class Expense < ApplicationRecord
  # belongs_to :group, optional: true
  belongs_to :group
  has_many :expense_payers, dependent: :destroy
  has_many :users, through: :expense_payers
  accepts_nested_attributes_for :expense_payers

  validates :amount, presence: true, numericality: { greater_than: 0 }
end
