FactoryGirl.define do
  factory :user do
    name               { Faker::Name.name }
    email              { Faker::Internet.email }
    city               { Faker::Address.city }
    province           { Faker::AddressUS.state_abbr }
    country            { Faker::ArrayUtils.rand(["USA", "Canada", "Russia"]) }
    zip_code           { Faker::AddressUS.zip_code }
    phone              { Faker::PhoneNumber.phone_number }
    encrypted_password { SecureRandom.hex(16) }
    main_image         { "http://" + Faker::ArrayUtils.rand(["meetup", "linkedin", "facebook", "twitter"]) + ".com/" + SecureRandom.hex(13) + ".png" }
    main_url           { "http://" + Faker::ArrayUtils.rand(["meetup", "linkedin", "facebook", "twitter"]) + ".com/" + Faker::Internet.user_name }
    main_description   { Faker::Lorem.sentence }
  end
end