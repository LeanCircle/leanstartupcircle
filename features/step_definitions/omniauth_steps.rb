When /^I login with ([^\"]*)$/ do |provider|
  visit "/users/auth/#{provider.downcase}"
end