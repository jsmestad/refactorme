Feature: Manage Snippets
  
  Scenario: Snippet of the Day
    Given that an active snippet exists
    When I visit the main page
    Then I should see a snippet for today
  
  Scenario: Submit New Snippet
    Given I am logged in
    When I visit the main page
    And I click "submit"
    And I fill in "Title" with "Rails 3 Commit"
    And I fill in "Description" with "I am not sure the proper way to pass the thing variable."
    And I fill in "Code" with "def hello(thing)"
    And I press "Submit"
    Then I should see a success message
    
  Scenario: Viewing Snippet Queue
    Given that a snippet exists
    And I am logged in as an admin
    When I visit the main page
    And I click "Snippet Queue"
    Then I should see "1" pending snippet
  
  # Scenario: Approving Snippet
  #   Given that a snippet exists
  #   And I am logged in as an admin
  #   And I visit the snippet queue page
  #   When I click "approve"
  #   And I visit the snippet queue page
  #   Then I should see "1" approved snippet
  # 
  # Scenario: Rejecting Snippet
  #   Given that a snippet exists
  #   And I am logged in as an admin
  #   And I visit the snippet queue page
  #   When I click "Reject"
  #   Then I should see a success message
  #   And I should not see any snippets

  Scenario: Snippet Selection Task
    Given that an approved snippet exists with the title "Snippet Today"
    When the nightly rake task runs
    And I visit the main page
    Then I should see a snippet with the title "Snippet Today"
    