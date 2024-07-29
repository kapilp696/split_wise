require 'rails_helper'

RSpec.describe Expense, type: :model do
  it { should belong_to(:group) }
  it { should belong_to(:user) }
  it { should have_many(:debts).dependent(:destroy) }

  it { should validate_presence_of(:amount) }
  it { should validate_numericality_of(:amount).is_greater_than(0) }
  it { should validate_presence_of(:description) }
  it { should validate_length_of(:description).is_at_most(255) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:group_id) }
end
