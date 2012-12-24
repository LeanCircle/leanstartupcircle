FactoryGirl.define do
  factory :group do
    city = Faker::Address.city
    name              "Lean Startup Meetup " + city
    description        Faker::Lorem.sentence
    meetup_id          rand(10000)
    organizer_id       rand(100000)
    twitter_link       Faker::Internet.http_url
    facebook_link      Faker::Internet.http_url
    linkedin_link      Faker::Internet.http_url
    googleplus_link    Faker::Internet.http_url
    other_link         Faker::Internet.http_url
    meetup_link        Faker::Internet.http_url
    city               city
    country            Faker::ArrayUtils.rand(["USA", "Canada", "Russia"])
    province           Faker::AddressUS.state_abbr
    highres_photo_url  Faker::Internet.http_url
    photo_url          Faker::Internet.http_url
    thumbnail_url      Faker::Internet.http_url
    join_mode          Faker::ArrayUtils.rand(["true", "false"])
    visibility         Faker::ArrayUtils.rand(["true", "false"])
    country_code       Faker::ArrayUtils.rand(["US", "CA", "RU"])
  end
end