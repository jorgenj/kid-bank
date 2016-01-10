FactoryGirl.define do
    factory :transaction do
      association :account
      association :journal

      transaction_type 'DEPOSIT'
      note 'my note'
      amount 10_0000 #$10 in pennies
    end
end
