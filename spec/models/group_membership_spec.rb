require 'rails_helper'

RSpec.describe GroupMembership, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:group) }

  it { should validate_presence_of(:user_id) }
end
