class Expense < ApplicationRecord
  belongs_to :group
  belongs_to :user

  has_many :debts, dependent: :destroy

  validates :description, presence: true, length: { maximum: 255 }
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :user_id, presence: true
  validates :group_id, presence: true
end
