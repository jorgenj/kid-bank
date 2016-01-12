FactoryGirl.define do
    factory :transaction do
      association :account
      association :journal

      transaction_type 'DEPOSIT'
      note 'my note'
      amount 10_0000 #$10 in pennies
    end

    factory :deposit, parent: :transaction do
      transaction_type 'DEPOSIT'
    end

    factory :withdrawal, parent: :transaction do
      transaction_type 'WITHDRAWAL'
    end
end
