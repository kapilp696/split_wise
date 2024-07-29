FactoryBot.define do
  factory :expense do
    description { Faker::Lorem.sentence }
    amount { 100.0 }
    association :user
    association :group
  end
end
