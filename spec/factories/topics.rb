FactoryGirl.define do
  factory :topic do
    title Faker::Hipster.sentence(3, true)
    user
  end
end
