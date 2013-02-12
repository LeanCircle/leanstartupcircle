require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

Given /^I am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^I go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^I press "([^\"]*)"(?: within "([^\"]*)")?$/ do |button, scope|
  scope = scope ? scope : "body"
  within(scope) do
    click_button(button)
  end
end

When /^I click "([^\"]*)"(?: within "([^\"]*)")?$/ do |link, scope|
  scope = scope ? scope : "body"
  within(scope) do
    click_link(link)
  end
end

When /^I click the image "([^\"]*)"(?: within "([^\"]*)")?$/ do |img, scope|
  scope = scope ? scope : "body"
  within(scope) do
    find(:xpath, ".//img[contains(@src, '#{img}.png')]/parent::a").click()
  end
end

When /^I fill in "([^\"]*)" with "([^\"]*)"(?: within (.*))?$/ do |field, value, scope|
  scope = scope ? scope + "_" : ""
  fill_in(scope + field.downcase.gsub(' ', '_'), :with => value)
end

When /^I fill in "([^\"]*)" for "([^\"]*)"$/ do |value, field|
  fill_in(field.gsub(' ', '_'), :with => value)
end

When /^I fill in the following:$/ do |fields|
  fields.rows_hash.each do |name, value|
    When %{I fill in "#{name}" with "#{value}"}
  end
end

When /^I select "([^\"]*)" from "([^\"]*)"$/ do |value, field|
  select(value, :from => field)
end

When /^I (?:(check|uncheck|choose))? "([^\"]*)"$/ do |action, field|
  eval("#{action}(field)")
end

Then /^I should( not)? see "([^\"]*)"(?: within "([^\"]*)")?$/ do |negate, text, scope|
  scope = scope ? scope : "body"
  within(scope) do
    negate ? page.should_not(have_content(text)) : page.should(have_content(text))
  end
end

Then /^I should( not)? see \/([^\/]*)\/$/ do |negate, regexp|
  regexp = Regexp.new(regexp)
  negate ? page.should_not(have_content(regexp)) : page.should(have_content(regexp))
end

Then /^the "([^\"]*)" field should contain "([^\"]*)"$/ do |field, value|
  find_field(field).value.should =~ /#{value}/
end

Then /^the "([^\"]*)" field should not contain "([^\"]*)"$/ do |field, value|
  find_field(field).value.should_not =~ /#{value}/
end

Then /^the "([^\"]*)" checkbox should be checked$/ do |label|
  find_field(label).should be_checked
end

Then /^the "([^\"]*)" checkbox should not be checked$/ do |label|
  find_field(label).should_not be_checked
end

Then /^I should be on (.+)$/ do |page_name|
  current_path.should == path_to(page_name)
end

Then /^I should be redirected to "([^\"]*)"$/ do |url|
  current_url.should include(url)
end

Then /^page should have (.+) message "([^\"]*)"$/ do |type, text|
  page.has_css?("p.#{type}", :text => text, :visible => true)
end