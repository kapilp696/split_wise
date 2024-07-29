FactoryBot.define do
  factory :debt do
    amount { 50.0 }
    settled { false }
    association :from_user, factory: :user
    association :to_user, factory: :user
    association :group
    association :expense, factory: :expense
  end
end