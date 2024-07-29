require 'rails_helper'

RSpec.describe Group, type: :model do
  it { should have_many(:group_memberships).dependent(:destroy) }
  it { should have_many(:users).through(:group_memberships) }
  it { should have_many(:debts) }
  it { should have_many(:expenses).dependent(:destroy) }

  it { should accept_nested_attributes_for(:group_memberships).allow_destroy(true) }

  it { should validate_presence_of(:name) }
end
