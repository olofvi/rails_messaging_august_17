Given(/^the following users exists$/) do |table|
  table.hashes.each do |hash|
    User.create!(hash)
  end
end

Given(/^I'm on the "([^"]*)" page$/) do |page|
  visit root_path
end

And(/^I click on "([^"]*)"$/) do |unicorn|
  click_link_or_button unicorn
end

And(/^I fill in "([^"]*)" with "([^"]*)"$/) do |field, content|
  fill_in(field, with: content)
end

Then(/^I should see "([^"]*)"$/) do |message|
  expect(page).to have_text message
end

Given(/^I am a registered user$/) do
  @current_user = User.create(name: 'sender',
                               email: 'sender@test.com',
                               password: 'password',
                               password_confirmation: 'password')
end

And(/^I am on the "([^"]*)" page$/) do |page|
  visit root_path
end

Then(/^I should be on the "([^"]*)" page$/) do |page|
  expect(current_path).to eq '/users'
end
