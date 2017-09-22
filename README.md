## CA Mailboxer April 2017

Code base for week 5 challenge - Working with legacy code

The team got a legacy code to work with and our assignment was to:
* Write Acceptance tests for the entire workflow using either RSpec OR Cucumber
* Write Unit tests for the models using RSpec
* Set up an automated way of deploying the software.

### Setting the stage

First thing first, to start this assignment we needed to set up the testing environment. Nurlan and Basil set up Rspec for the specs and Cucumber for feature testing. Ólöf set up Coveralls and Travis to keep track of the status of the testing.

### Unit testing mailboxer & user class

Magnús and Amanda maid unit test for the mailboxer gem and the user class using Rspec and Cucumber as testing framework. The tests that they made were:

* Specs for sending, receiving, replying & deleting message.
* Testing user validation, and mailboxer methods mailboxer_name and mailboxer_email.
* Testing our database to see that it has the right columns.

Feature testing sending mail
* User can log in
* User can create an email
* User can reply to an email
* User can trash an email
* User can untrash an email
* User can see messages it has sent

In that process they found a bug in the application that was if the user had an empty field the website would crash. Fixed that bug with adding a redirect & alert if you try to send message without filling out all fields.Added also alerts for trashing messages.

### Feature testing user management

Nurlan and Basil made feature test for the user management using Cucumber. The tests that they made were:

* User can sign up
* User can log in
* User can log out
* Sad paths for these scenarios

### Automated way of deploying the software

Ólöf got the assignment to set up a automated way to deploy the application. When Travis was all set up it was decided to use that also as a tool for automatically deploying the website with Heroku. Then settings are in the .travis.yml file:

* setting the provider to Heroku
* Making an encrypted API key
* linking it to the app on Heroku :railsmessagingaugust17
* Defining on what Github repo to deploy from :CraftAcademy/rails_messaging_august_17
* Setting the deploy branch to :devlop

#### To view the app go to link: https://railsmessagingaugust17.herokuapp.com/

#### To view the test coverage:
[![Coverage Status](https://coveralls.io/repos/github/CraftAcademy/rails_messaging_august_17/badge.svg)](https://coveralls.io/github/CraftAcademy/rails_messaging_august_17)
