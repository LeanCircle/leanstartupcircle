Given /^There (?:is|are) (?:a) users? named (.*?)$/ do |names|
  names.split(', ').each do |name|
    FactoryGirl.create :user, :name => name
  end
end

Given /^I have an account as folowing:$/ do |table|
  table.hashes.each do |attributes|
    FactoryGirl.create(:user, attributes)
  end
end

Given /^There are no users$/ do
  User.delete_all
end

Then /^There should be ([0-9]+) users?$/ do |count|
  User.count.should == count.to_i
end