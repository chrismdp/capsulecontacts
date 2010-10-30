When /^I search for "([^"]*)"$/ do |query|
  visit root_path
  fill_in "Find", with: query
  click_button 'Find'
end

Then /^I should get (\d+) contacts? back$/ do |contact_count|
  page.should have_css('.contact', count: contact_count.to_i)
end

