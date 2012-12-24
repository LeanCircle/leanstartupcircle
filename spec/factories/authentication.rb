FactoryGirl.define do
  factory :authentication do
    association :user
    provider    { Faker::ArrayUtils.rand(["meetup", "linkedin", "facebook", "twitter"]) }
    uid         { SecureRandom.hex(6) }
    token       { SecureRandom.hex(7) }
    secret      { SecureRandom.hex(16) }
    image       { "http://" + Faker::ArrayUtils.rand(["meetup", "linkedin", "facebook", "twitter"]) + ".com/" + SecureRandom.hex(13) + ".png" }
    url         { "http://" + Faker::ArrayUtils.rand(["meetup", "linkedin", "facebook", "twitter"]) + ".com/" + Faker::Internet.user_name }
    name        { Faker::Name.name }
    location    { Faker::Address.street_address }
    description { Faker::Lorem.sentence }
  end
end