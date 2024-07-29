require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:group_memberships) }
  it { should have_many(:groups).through(:group_memberships) }
  it { should have_many(:debts).with_foreign_key(:from_user_id) }
  it { should have_many(:credits).class_name('Debt').with_foreign_key(:to_user_id) }
  it { should have_many(:expenses) }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  describe '#total_borrowed' do
    it 'returns the total borrowed amount' do
      user = create(:user)
      group = create(:group)
      create(:debt, from_user: user, amount: 100, settled: false)
      create(:debt, from_user: user, amount: 200, settled: false)
      create(:debt, from_user: user, amount: 300, settled: true)
      expect(user.total_borrowed).to eq(300)
    end
  end

  describe '#total_lent' do
    it 'returns the total lent amount' do
      user = create(:user)
      create(:debt, to_user: user, amount: 100, settled: false)
      create(:debt, to_user: user, amount: 200, settled: false)
      create(:debt, to_user: user, amount: 300, settled: true)
      expect(user.total_lent).to eq(300)
    end
  end
end
