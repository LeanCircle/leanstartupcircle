Given /^I have groups titled (.*?)$/ do |names|
  names.split(', ').each do |name|
    Group.create(:name => name, :approval => true, :city => "New York")
  end
end