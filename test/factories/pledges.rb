FactoryBot.define do
  factory :pledge do
    dollar_amount {generate(:dollar_amount)}
    user
  end
  sequence :dollar_amount do |n|
    rand(0..500)
  end
end
