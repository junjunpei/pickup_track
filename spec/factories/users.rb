FactoryBot.define do
  factory :user do
    name { "example" }
    password { "pass" }
    password_confirmation { "pass" }
    sequence(:email) { |n| "tester#{n}@example.com" }
  end
end
