require 'rails_helper'

RSpec.describe Debt, type: :model do
  it { should belong_to(:from_user).class_name('User') }
  it { should belong_to(:to_user).class_name('User') }
  it { should belong_to(:group).optional }
  it { should belong_to(:expense) }

  it { should validate_presence_of(:amount) }
  it { should validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
  it { should validate_presence_of(:from_user_id) }
  it { should validate_presence_of(:to_user_id) }
  it { should validate_presence_of(:expense_id) }
end
