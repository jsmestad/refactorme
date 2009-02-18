Feature: Manage Refactors

  Scenario: New Refactor
    Given I am logged in as "john_doe"
    And that a snippet exists
    When I click "Refactor"
    And I fill in "Code" with "@thing.each { |x| x.thingy }"
    And I press "Submit"
    Then I should see a refactor by "john_doe"
    And I should see a notice message
    
  Scenario: Vote For Refactor
    Given I am logged in
    And that a snippet exists with a refactor
    When I click "+1"
    Then I should see a notice message
    And the score should increase from "0" to "1"
  
  Scenario: Vote Against Refactor
    Given I am logged in
    And that a snippet exists with a refactor
    When I click "-1"
    Then I should see a notice message
    And the score should increase from "0" to "-1"
