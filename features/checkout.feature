Feature: Checkout
  As a user
  I'd like to be able to perform a checkout
  So that I can purchase wine



  Background:
    Given we have the following Wines:
      | name   |
      | wine01 |
      | wine02 |
      | wine03 |


  Scenario: Attempt checkout whilst logged out
    Given I am not logged in
    And I have added "wine01" to my basket
    When I attempt to checkout
    Then I should be prompted to log in


  Scenario: Attempt checkout whilst logged in
    Given I am logged in
    And I have added "wine01" to my basket
    When I attempt to checkout
    Then I should be able to place an order