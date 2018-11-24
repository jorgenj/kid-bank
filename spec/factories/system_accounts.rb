FactoryBot.define do
  factory :system_account do
    name { "account name" }
    association :account
  end
end
