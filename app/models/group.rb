class Group < ApplicationRecord
  has_many :group_memberships, dependent: :destroy
  has_many :users, through: :group_memberships

  accepts_nested_attributes_for :group_memberships, allow_destroy: true

  has_many :debts
  has_many :expenses, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { maximum: 100 }

  def group_memberships_attributes=(group_memberships_attributes)
    existing_user_ids=self.group_memberships.map(&:user_id)
    group_memberships_attributes.each do |i, group_memberships_attribute|
      next if group_memberships_attribute.has_value?("")
      user_id=group_memberships_attribute["user_id"]
      next if existing_user_ids.include?(user_id)
      self.group_memberships.build(group_memberships_attribute)
      existing_user_ids << user_id
    end
  end
end
