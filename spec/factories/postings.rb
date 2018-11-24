FactoryBot.define do
  factory :posting do
    association :account
    association :journal
    amount { 1 }
  end
end
