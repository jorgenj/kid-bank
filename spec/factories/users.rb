FactoryGirl.define do
  factory :user do
    email { |n| "user_#{n}@gmail.com" }
    password 's3cr3tp4ssw0rd'
  end
end
