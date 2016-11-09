# features/step_definitions/home_page_steps.rb
When(/^I am on the homepage$/) do
  visit root_path
end

Then(/^I should see the "(.*?)" header$/) do |header|
  expect(page).to have_content(header)
end
