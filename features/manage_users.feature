Feature: Manage Users
  As a first time visitor
  I want to login
  So that I can contribute code
  
  Scenario: Register new user
    Given I am on the new user page
    When I fill in "Login" with "john_doe"
    And I fill in "Email" with "john_doe@example.com"
    And I fill in "Password" with "secret"
    And I press "Create"
    Then I should see "john_doe"
    And I should see "john_doe@example.com"
    And I should see "secret"

  Scenario: Delete user
    Given the following users:
      |login|email|password|
      |login 1|email 1|password 1|
      |login 2|email 2|cryped_password 2|
      |login 3|email 3|cryped_password 3|
      |login 4|email 4|cryped_password 4|
    When I delete the 3rd user
    Then I should see the following users:
      |login|email|password|
      |login 1|email 1|cryped_password 1|
      |login 2|email 2|cryped_password 2|
      |login 4|email 4|cryped_password 4|
