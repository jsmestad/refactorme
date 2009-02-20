Feature: Manage Users
  
  Scenario: Register new user
    Given I visit the registration page
    When I fill in "Login" with "john_doe"
    And I fill in "Email" with "john_doe@example.com"
    And I fill in "Password" with "secret"
    And I fill in "Password Confirmation" with "secret"
    And I press "Register"
    Then I should see a success message
    And I should see "john_doe"
    And I should see "john_doe@example.com"
    
  Scenario: Logging In
    Given a user exists with login "jdoe" and password "secret"
    When I visit the login page
    And I fill in "Login" with "jdoe"
    And I fill in "Password" with "secret"
    And I press "Login"
    Then I should see a success message

