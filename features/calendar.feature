Feature: Calendar
  
  Scenario: See today's post
    Given I am on the calendar page
    Then I verify the page contains today's date
    And I click on today's date
    Then I verify the page contains the text "Today's Snippet"

  Scenario: Visit yesterday's post
    Given a post exists for today
    And I am on the calendar page
    Then I verify the page contains yesterday's date
    And I click on yesterday's date
    Then I verify the page contains the text "Yesterday's Snippet"

  Scenario: Visit a post from last month
    Given I am on the calendar page
    Then I verify the page contains today's date
    And I click on the back button
    And I verify the calendar is from last month
    And I click on a post from last month
    Then I verify the page contains the date from last month
