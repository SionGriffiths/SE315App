Feature: Search
  As a user
  I want to be able to search for wines by any attribute
  So I can find wines of interest

  Scenario: Find wines by name

    Given we have the following Wines:
      | name   | short_description | price |
      | wine10 | short desc1       | 2.99  |
      | wine02 | short desc2       | 13.99 |
      | wine11 | short desc3       | 10.99 |

    When I search for Wine "wine1"
    Then the results must be:
      | name   | short_description | price |
      | wine10 | short desc1       | 2.99  |
      | wine11 | short desc3       | 10.99 |



  Scenario: Find wines by multiple terms
    Given we have the following Wines:
      | name   | short_description | price |
      | wine10 | short desc       | 2.99  |
      | wine02 | short desc       | 13.99 |
      | wine11 | short desc       | 10.99 |

    When I search for Wine "short desc 2.99"
    Then the results must be:
      | name   | short_description | price |
      | wine10 | short desc      | 2.99  |

