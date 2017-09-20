Feature: As a user in order to use the application
    I should be able to sign up for account
    I should be able to log in
    I should be able to log out

    Scenario: Register User
      Given I'm on the "home" page
      And I click on "Sign up"
      And I fill in "Name" with "Sender"
      And I fill in "Email" with "sender@test.com"
      And I fill in "Password" with "password"
      And I fill in "Password confirmation" with "password"
      And I click on "Create"
      And I should see "Welcome! You have signed up successfully"

    Scenario: Login User
      Given I am a registered user
      And I am on the "home" page
      And I click on "Login"
      And I fill in "Email" with "sender@test.com"
      And I fill in "Password" with "password"
      And I click on "Log in"
      And I should see "Signed in successfully."
