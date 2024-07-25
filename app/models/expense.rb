class Expense < ApplicationRecord
  belongs_to :group
  belongs_to :user

  validates :amount, presence: true, numericality: { greater_than: 0 }
end
