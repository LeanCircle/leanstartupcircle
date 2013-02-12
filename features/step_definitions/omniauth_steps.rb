When /^I login with ([^\"]*)$/ do |provider|
  visit "/users/auth/#{provider.downcase}"
end

Given /^I am not signed in$/ do
  visit('/sign_out')
end