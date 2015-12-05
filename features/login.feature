Feature: Login
  As a User
  I want to be able to register an account and log into the site
  So that I can place orders.

  Scenario: Log in with valid credentials
    Given I am not logged in
    When I try to log into the site with valid credentials
    Then I should successfully log in