Given(/^I am on the site$/) do
  visit root_path
end

Given(/^There is a user called "([^"]*)" with email "([^"]*)" in our database$/) do |name, email|
  FactoryGirl.create(:user, name: name, email: email)
end

Given(/^I log in as "([^"]*)"$/) do |name|
  user = User.find_by name: name
  login_as(user)
end

Given(/^I am on the inbox page$/) do
  visit mailbox_inbox_path
end

Then(/^I press "([^"]*)"$/) do |button|
  click_link_or_button button
end

Then(/^I choose "([^"]*)" as a recipient from the list$/) do |user|
  select user, from: "conversation_recipients"
end

Then(/^I fill in the field "([^"]*)" with "([^"]*)"$/) do |field, content|
  fill_in field, with: content
end

Then(/^I should see the text "([^"]*)"$/) do |message|
  expect(page).to have_content message
end

Given(/^I have mail from "([^"]*)" to "([^"]*)"$/) do |sender, receiver|
  sender = User.find_by name: sender
  receiver = User.find_by name: receiver
  sender.send_message(receiver, "body", "subject")
end
