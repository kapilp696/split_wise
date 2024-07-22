class Group < ApplicationRecord
  has_many :group_memberships
  has_many :groups, through: :group_memberships

  has_many :users
  has_many :debts
  has_many :expenses
end
