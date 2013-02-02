Given /^there (?:is|are) (?:a) groups? titled (.*?)$/ do |names|
  names.split(', ').each do |name|
    FactoryGirl.create :group, :name => name, :approval => true, :city => "New York"
  end
end

Given /^There are no groups$/ do
  Group.delete_all
end

Then /^There should be ([0-9]+) groups?$/ do |count|
  Group.count.should == count.to_i
end