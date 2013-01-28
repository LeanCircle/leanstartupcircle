Given /^I have (?:a) users? named (.*?)$/ do |names|
  names.split(', ').each do |name|
    FactoryGirl.create :user, :name => name
  end
end

Given /^I have no users$/ do
  User.delete_all
end

Then /^I should have ([0-9]+) user$/ do |count|
  User.count.should == count.to_i
end