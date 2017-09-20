Feature: As a user in order to use the application
    I should be able to sign up for account
    I should be able to log in
    I should be able to log out

    Background:
    Given the following users exists
      | name   | email           | password | password_confirmation |
      | sender | sender@test.com | password | password              |

    Scenario: Register User
      Given I'm on the "home" page
      And I click on "Sign up"
      And I fill in "Name" with "receiver"
      And I fill in "Email" with "receiver@test.com"
      And I fill in "Password" with "password"
      And I fill in "Password confirmation" with "password"
      And I click on "Create"
      And I should see "Welcome! You have signed up successfully"

    Scenario: Register user without name
      Given I'm on the "home" page
      And I click on "Sign up"
      And I fill in "Name" with " "
      And I fill in "Email" with "sender@test.com"
      And I fill in "Password" with "password"
      And I fill in "Password confirmation" with "password"
      And I click on "Create"
      And I should see "Name can't be blank"

    Scenario: Register user without Email
      Given I'm on the "home" page
      And I click on "Sign up"
      And I fill in "Name" with "sender"
      And I fill in "Email" with " "
      And I fill in "Password" with "password"
      And I fill in "Password confirmation" with "password"
      And I click on "Create"
      And I should see "Email can't be blank"

    Scenario: Register user with no match password
      Given I'm on the "home" page
      And I click on "Sign up"
      And I fill in "Name" with "sender"
      And I fill in "Email" with "sender@test.com"
      And I fill in "Password" with "password"
      And I fill in "Password confirmation" with "nopassword"
      And I click on "Create"
      And I should see "Password confirmation doesn't match Password"

    Scenario: Register user with short password
      Given I'm on the "home" page
      And I click on "Sign up"
      And I fill in "Name" with "sender"
      And I fill in "Email" with "sender@test.com"
      And I fill in "Password" with "pass"
      And I fill in "Password confirmation" with "pass"
      And I click on "Create"
      And I should see "Password is too short (minimum is 8 characters)"

    Scenario: Register user with already taken name
      Given I'm on the "home" page
      And I click on "Sign up"
      And I fill in "Name" with "sender"
      And I fill in "Email" with "receiver@test.com"
      And I fill in "Password" with "password"
      And I fill in "Password confirmation" with "password"
      And I click on "Create"
      Then I should be on the "users" page
      And I should see "Name has already been taken"

    Scenario: Login User
      Given I am a registered user
      And I am on the "home" page
      And I click on "Login"
      And I fill in "Email" with "sender@test.com"
      And I fill in "Password" with "password"
      And I click on "Log in"
      And I should see "Signed in successfully."
