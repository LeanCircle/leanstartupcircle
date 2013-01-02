Given /^I have groups titled (.*?)$/ do |names|
  names.split(', ').each do |name|
    Group.create(:name => name, :approval => true, :city => "New York")
  end
end

Given /^I have no groups$/ do
  Group.delete_all
end

Then /^I should have ([0-9]+) group$/ do |count|
  Group.count.should == count.to_i
end