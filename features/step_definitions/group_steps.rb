Given /^there (?:is |are )(?:a )?groups? named (.*?)$/ do |names|
  names.split(', ').each do |name|
    FactoryGirl.create :group, :name => name, :approval => true, :city => "New York"
  end
end

Given /^there (?:is |are )(?:a )?groups? with attributes:$/ do |table|
  table.hashes.each do |attributes|
    FactoryGirl.create(:group, attributes)
  end
end

Given /^there are no groups$/ do
  Group.delete_all
end

Then /^there should be ([0-9]+) groups?$/ do |count|
  Group.count.should == count.to_i
end