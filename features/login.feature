Feature: Login
  As a User
  I want to be able to register an account and log into the site
  So that I can place orders.

  Background:
    Given I am not logged in

  Scenario: Log in with valid credentials
    When I try to log into the site with valid credentials
    Then I should successfully log in


  Scenario: Attempt login with invalid credentials
    When I try to log into the site with invalid credentials
    Then I should be prompted to log in again


  Scenario: Register a new user account
    When I go to the register page
    And I fill in and submit the registration form
    Then I should be logged in as the new user

  Scenario: Able to log out
    When I try to log into the site with valid credentials
    And I attempt to log out
    Then I should be logged out