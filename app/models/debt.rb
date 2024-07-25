class Debt < ApplicationRecord
  belongs_to :from_user, class_name: 'User'
  belongs_to :to_user, class_name: 'User'
  belongs_to :group, optional: true
  belongs_to :expense

    # Default value for settled
  attribute :settled, :boolean, default: false

end
