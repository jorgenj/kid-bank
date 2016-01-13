FactoryGirl.define do
    factory :account do
      name "account name"

      before(:create) { |account|
        account.user = create(:user) if account.user.nil?
      }
    end

    factory :cash_account, parent: :account do
      name "CASH"

      after(:create) { |account|
        create(:system_account, account: account, name: account.name)
      }
    end

    factory :interest_account, parent: :account do
      name "INTEREST"

      after(:create) { |account|
        create(:system_account, account: account, name: account.name)
      }
    end
end
