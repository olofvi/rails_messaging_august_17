## CA Mailboxer August 2017

Code base for week 5 challenge - Working with legacy code

The team received legacy code to work with, and our assignment was:
* Write Acceptance tests for the entire workflow using either RSpec OR Cucumber (we choose Cucumber)
* Write Unit tests for the models using RSpec
* Set up an automated way of deploying the software.
* Set up continuous testing

### Setting the stage

First thing first - to start this assignment we needed to set up the testing environment. Nurlan and Basil set up Rspec for the specs, and Cucumber for feature testing. Ólöf set up Coveralls and Travis to keep track of the testing.

### Unit testing mailboxer + user class and feature testing sending email

Magnús and Amanda created unit tests for the mailboxer gem and the user class, using Rspec as testing framework.
* Specs for sending, receiving, replying & deleting message.
* Testing user validation, and mailboxer methods mailboxer_name and mailboxer_email.
* Testing our database to see that it had the right columns.

They also created feature tests for sending mail, using Cucumber as testing framework.
* User can log in
* User can create an email
* User can reply to an email
* User can trash an email
* User can untrash an email
* User can see messages it has sent

In that process they found a bug in the application - if the user had an empty field while trying to send an email, the website would crash. They fixed that bug by adding a redirect back to "create message" and an alert telling you that you have to fill out all fields. They also added a warning alert for when you delete a messages.

### Feature testing the user management

Nurlan and Basil created feature tests for the user management (Devise) using Cucumber.

* User can sign up
* User can log in
* User can log out
* Sad paths for those scenarios

### Automated way of deploying the software

Ólöf got the assignment to set up a automated way to deploy the application. After Travis was set up she decided to use it as a tool for automatically deploying the website with Heroku. The settings are in the .travis.yml file.

* Setting the provider to Heroku
* Making an encrypted API key
* Linking it to the app on Heroku :railsmessagingaugust17
* Defining on what Github repo to deploy from :CraftAcademy/rails_messaging_august_17
* Setting the deploy branch to :devlop

#### To view the app go to link: https://railsmessagingaugust17.herokuapp.com/

#### To view the test coverage:
[![Coverage Status](https://coveralls.io/repos/github/CraftAcademy/rails_messaging_august_17/badge.svg)](https://coveralls.io/github/CraftAcademy/rails_messaging_august_17)
