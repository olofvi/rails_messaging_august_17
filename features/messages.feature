Feature: User should be able to use mail service
  I should be able to log in
  And I should be able to create an email
  And I should be able to reply to an email
  And I should be able to trash an email
  And I should be able to untrash an email
  And I should be able to see what message I've sent

  Background:
    Given I am on the site
    And There is a user called "Raoul" with email "raoul@test.com" in our database
    And There is a user called "Faraz" with email "faraz@test.com" in our database
    And I log in as "Raoul"
    And I am on the inbox page


  Scenario: User should be able to send message
    Given I press "Inbox"
    And I press "Compose"
    And I choose "Faraz" as a recipient from the list
    And I fill in the field "Subject" with "subject"
    And I fill in the field "Type your message here" with "message"
    And I press "Send Message"
    Then I should see the text "Your message was successfully sent!"

  Scenario: User can reply to message
    Given I have mail from "Faraz" to "Raoul"
    And I press "Inbox"
    And I press "View"
    And I fill in the field "Reply Message" with "reply message"
    And I press "Reply"
    Then I should see the text "Your reply message was successfully sent!"

  Scenario: User can trash a message
    Given I have mail from "Faraz" to "Raoul"
    And I press "Inbox"
    And I press "View"
    And I press "Move to trash"
    And I press "Trash"
    Then I should see the text "body"

  Scenario: User can untrash a message
    Given I have mail from "Faraz" to "Raoul"
    And I press "Inbox"
    And I press "View"
    And I press "Move to trash"
    And I press "Trash"
    And I press "View"
    And I press "Untrash"
    Then I should see the text "body"

  Scenario: User can see sent messages
    Given I press "Inbox"
    And I press "Compose"
    And I choose "Faraz" as a recipient from the list
    And I fill in the field "Subject" with "subject"
    And I fill in the field "Type your message here" with "some awesome message"
    And I press "Send Message"
    Then I should see the text "Your message was successfully sent!"
    Given I press "Sent"
    Then I should see the text "some awesome message"

  Scenario: User leaves an empty field
    Given I press "Inbox"
    And I press "Compose"
    And I choose "Faraz" as a recipient from the list
    And I fill in the field "Subject" with ""
    And I fill in the field "Type your message here" with ""
    And I press "Send Message"
    Then I should see the text "You need to fill out all the fields"