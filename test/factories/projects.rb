FactoryBot.define do
  factory :project do
    title "Big new ProjectTest"
    user
    description "nice project"
    goal 1000
    start_date Time.now + 1.day
    end_date Time.now + 3.day
    category
  end
end
