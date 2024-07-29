class Debt < ApplicationRecord
  belongs_to :from_user, class_name: 'User'
  belongs_to :to_user, class_name: 'User'
  belongs_to :group, optional: true
  belongs_to :expense

  attribute :settled, :boolean, default: false

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :from_user_id, presence: true
  validates :to_user_id, presence: true
  validates :expense_id, presence: true
end
