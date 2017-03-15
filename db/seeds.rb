require 'faker'

5.times do
  User.create!(
    email: Faker::Internet.safe_email,
    username: Faker::Internet.user_name,
    password: Faker::Internet.password(6, 8)
  )
end

users = User.all

5.times do
  Topic.create!(
    user: users.sample,
    title: Faker::Hipster.sentence(1)
  )
end

topics = Topic.all

25.times do
  Bookmark.create!(
    topic: topics.sample,
    url: Faker::Internet.url
  )
end

admin = User.create!(
  email:    'jayson@test.com',
  username: 'jabels',
  password: 'password'
)

puts "Seed finshed"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Bookmark.count} bookmarks created"
