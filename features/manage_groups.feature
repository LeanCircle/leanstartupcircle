Feature: Manage Groups
  In order to be included in the directory
  As an organizer
  I want to create and manage a group

  Scenario: Groups List
      Given I have groups titled Lean Startup Circle San Francisco, Lean Startup New York
      When I go to the list of groups
      Then I should see "Lean Startup Circle San Francisco"
      And I should see "Lean Startup New York"