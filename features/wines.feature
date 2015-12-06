Feature: Wines
  As a user
  I want to be able to browse wines add them to my basket


  Background:
    Given we have the following Wines:
      | name   | short_description | price |
      | wine01 | short desc1       | 2.99  |
      | wine02 | short desc2       | 13.99 |
      | wine11 | short desc3       | 10.99 |
    And I am on the wines listing page

  Scenario: View individual wine details by clicking an image
    When I click on the image for "wine01"
    Then I can view details for that wine:
      | name   | short_description | price |
      | wine01 | short desc1       | 2.99  |

  Scenario: Able to add a quantity of wine to basket
    When I click on the image for "wine11"
    And I add 78 of that wine to my basket
    Then I should have 78 of "wine11" in my basket


  Scenario: Able to remove a wine from basket
    When I click on the image for "wine11"
    And I add 2 of that wine to my basket
    And I remove "wine11" from my basket
    Then My basket should be empty



  Scenario Outline: View all details for a wine
    When I click on the image for "wine02"
    Then I can see the following <field_names> detailed in the page

    Examples:
      | field_names       |
      | Name             |
      | Description      |
      | Short description|
      | Country of origin|
      | Grape type       |
      | Vegetarian       |
      | Price            |
      | Supplier company |
      | Product number   |
      | Bottle size      |