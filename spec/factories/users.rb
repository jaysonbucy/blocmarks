FactoryGirl.define do
  factory :user do
    email Faker::Internet.unique.safe_email
    username Faker::Internet.user_name
    password "password"
    password_confirmation "password"
  end
end
