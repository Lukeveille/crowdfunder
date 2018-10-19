Pledge.destroy_all
Reward.destroy_all
Project.destroy_all
Category.destroy_all

Category.create(
  name: "Games"
)
Category.create(
  name: "Art"
)
Category.create(
  name: "Music"
)
Category.create(
  name: "Design & Tech"
)
Category.create(
  name: "Food & Craft"
)


5.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.free_email,
    password: 'password',
    password_confirmation: 'password'
  )
end

10.times do
  project = Project.create!(
    user: User.all.sample,
    title: Faker::App.name,
    description: Faker::Lorem.paragraph,
    goal: rand(100000),
    start_date: Time.now.utc + rand(1..10).days,
    end_date: Time.now.utc + rand(11..50).days,
    category: Category.all.sample
  )

  5.times do
    project.rewards.create!(
      description: Faker::Superhero.power,
      dollar_amount: rand(1..100),
    )
  end
end

20.times do
  project = Project.all.sample
  backer = User.all.sample

  while backer == project.user
    backer = User.all.sample
  end

  Pledge.create!(
    user: backer,
    project: project,
    dollar_amount: project.rewards.sample.dollar_amount + rand(1..10)
  )
end

# # Special case
# test_project = Project.create!(
#   user: User.find_by(first_name: "Test"),
#   title: "The test man knows",
#   description: "A test project for the test man.",
#   goal: 100,
#   start_date: Time.now.utc + 5,
#   end_date: Time.now.utc + 3*60,
#   category: Category.first,
#   image: "https://upload.wikimedia.org/wikipedia/en/d/dc/The_Test_series_logo.jpg"
# )
# Update.create!(
#   title: "All can see",
#   notes: "This was written while the project was active",
#   project: test_project
# )
# Pledge.create!(
#   user: User.find_by(first_name: "Luke"),
#   dollar_amount: 100,
#   project: test_project
# )
# Update.create!(
#   title: "Only a backer can see",
#   notes: "This was written after the project ended",
#   project: test_project,
#   created_at: Time.now.utc + 10*60
# )