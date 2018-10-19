FactoryBot.define do
  factory :user do
    first_name "Jack"
    last_name "Smith"
    email {generate(:email)}
    password "123456Password"
    password_confirmation "123456Password"
  end
  sequence :email do |n|
    "person#{n}@example.com"
  end
end
