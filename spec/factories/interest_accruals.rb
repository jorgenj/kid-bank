FactoryGirl.define do
  factory :interest_accrual do
    association :account
    accrued_on { Date.yesterday }
    amount 1.0
    account_end_balance 100
    applied { false }
  end
end
