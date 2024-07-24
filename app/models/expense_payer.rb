class ExpensePayer < ApplicationRecord
  belongs_to :user
  belongs_to :expense

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

end
