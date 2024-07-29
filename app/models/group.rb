class Group < ApplicationRecord
  has_many :group_memberships, dependent: :destroy
  has_many :users, through: :group_memberships

  has_many :debts
  has_many :expenses, dependent: :destroy

  accepts_nested_attributes_for :group_memberships, allow_destroy: true

  validates :name, presence: true, uniqueness: true, length: { maximum: 100 }

end
