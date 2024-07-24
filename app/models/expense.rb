class Expense < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true
  has_many :expense_payers
  has_many :users, through: :expense_payers
  has_many :payers, through: :expense_payers, source: :user
  accepts_nested_attributes_for :expense_payers, allow_destroy: true
  
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
