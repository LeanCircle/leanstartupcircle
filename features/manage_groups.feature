Feature: Manage Groups
  In order to be included in the directory
  As an organizer
  I want to create a group

  Scenario: Try to create valid group when not logged in
    Given I am not signed in
    When I am on the list of groups
    And I click "Add a Meetup" within ".main.container"
    Then I should be on the sign in form

  Scenario: Try to create valid group when logged in
    Given there are no groups
    And I login with twitter
    When I am on the new group form
    And I fill in "#group_name" with "LSC SF"
    And I press "Submit"
    Then there should be 1 group