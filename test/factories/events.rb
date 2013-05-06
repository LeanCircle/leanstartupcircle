# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    name "MyString"
    meeting_at "2013-04-19 16:47:16"
    location_name "MyString"
    location_address "MyString"
    group nil
  end
end
