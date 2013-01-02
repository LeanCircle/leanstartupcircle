Feature: Manage Groups
  In order to be included in the directory
  As an organizer
  I want to create and manage a group

  @javascript
  Scenario: Groups list
    Given I have groups titled Lean Startup Circle San Francisco, Lean Startup New York
    When I go to the list of groups
    Then I should see "Lean Startup Circle San Francisco"
    And I should see "Lean Startup New York"

  Scenario: Try to create valid group when not logged in
    Given I have no groups
    And I am on the list of groups
    When I click "Add a Meetup" within ".main.container"
    Then I should be on the sign in form

  Scenario: Try to create valid group when not logged in
    Given I have no groups
    And I login with twitter
    And I am on the list of groups
    When I click "Add a Meetup" within ".main.container"
    Then I should be on the new group form
    And I fill in "#group_name" with "LSC SF"
    And I press "Submit"
    Then I should see "New group created."
    And I should have 1 group
