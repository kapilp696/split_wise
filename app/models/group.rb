class Group < ApplicationRecord
  has_many :group_memberships, dependent: :destroy
  has_many :users, through: :group_memberships

  accepts_nested_attributes_for :group_memberships, allow_destroy: true, reject_if: :all_blank

  has_many :debts
  has_many :expenses, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { maximum: 100 }

end
