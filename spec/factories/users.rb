FactoryBot.define do
  factory :user do
    email { |n| "user_#{n}@gmail.com" }
    password { 's3cr3tp4ssw0rd' }
  end

  factory :admin_user, parent: :user do
    before(:create) { |user|
      user.add_role "admin"
    }
  end
end
