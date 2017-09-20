Given(/^I'm on the "([^"]*)" page$/) do |page|
  case page
    when 'home'
      visit '/'
    when 'Sign up'
      visit 'users/sign_up'
  end
end

And(/^I click on "([^"]*)"$/) do |unicorn|
  click_link_or_button unicorn
end

Then(/^I should be on the "([^"]*)" page$/) do |page|
  case page
    when 'Sign up'
      expect(current_path).to eq '/users/sign_up'
    end
end

And(/^I fill in "([^"]*)" with "([^"]*)"$/) do |form, content|
  fill_in(form, with: content)
end

Then(/^I should see "([^"]*)"$/) do |message|
  expect(page).to have_text message
end

Given(/^I am a registered user$/) do
  @current_user = User.create!(name: 'sender',
                               email: 'sender@test.com',
                               password: 'password',
                               password_confirmation: 'password')
end

Given(/^I am on the "([^"]*)" page$/) do |page|
  visit '/'
end
