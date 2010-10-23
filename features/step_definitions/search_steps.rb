When /^I search for "([^"]*)"$/ do |query|
  visit root_path
  fill_in :search, with: query
  click_button 'Find'
end

Then /^I should get (\d+) contact back$/ do |contact_count|
  page.should have_css('.contact', count: 2)
end

