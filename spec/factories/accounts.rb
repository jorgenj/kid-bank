FactoryGirl.define do
    factory :account do
      name "account name"

      before(:create) { |account|
        account.user = create(:user) if account.user.nil?
      }
    end

    factory :cash_account, parent: :account do
      name "CASH"
    end

    factory :interest_account, parent: :account do
      name "INTEREST"
    end
end
