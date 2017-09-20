FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "user#{n}"}
    email {"#{name}@test.com"}
    password 'password'
    end
end