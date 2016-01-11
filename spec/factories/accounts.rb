FactoryGirl.define do
    factory :account do
      name "account name"
    end

    factory :cash_account, parent: :account do
      name "CASH"
    end
end
