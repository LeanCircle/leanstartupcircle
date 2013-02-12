def include_marker?(type)
  markers_js = page.body[/(?<=Gmaps.map.markers = )\[.*\];/]
  case type
  when "small"
    (markers_js.include?('mm_20_orange.png') || markers_js.include?('mm_20_red.png'))
  when "large"
    (markers_js.include?('marker_orange.png') || markers_js.include?('marker.png'))
  when "red"
    (markers_js.include?('mm_20_red.png') || markers_js.include?('marker.png'))
  when "orange"
    (markers_js.include?('mm_20_orange.png') || markers_js.include?('marker_orange.png'))
  when
    false
  end
end

Given /^there (?:is |are )(?:a |an )?(approved )?(lsc )?groups? named (.*?)$/ do |approve, lsc, names|
	approve = approve ? true : false
	lsc = lsc ? true : false
  names.split(', ').each do |name|
    FactoryGirl.create :group, :name => name, :approval => approve, :lsc => lsc, :city => "New York"
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

Given /^I am located in San Francisco$/ do
end

When /^I click the map pin$/ do
  wait_for_page_load
  page.execute_script %Q{
    google.maps.event.trigger(Gmaps.map.markers[0].serviceObject, 'click');
  }
end

Then /^there should be ([0-9]+) groups?$/ do |count|
  Group.count.should == count.to_i
end

Then /^I should see (?:a) (?:(small|large|red|orange))? map pin$/ do |type|
  include_marker?(type).should be_true
end