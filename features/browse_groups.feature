@javascript
Feature: View Groups
  Alice wants to browse a directory of groups and find out more information about them

  Scenario: Groups list
    Given there are approved groups named Lean Startup Circle San Francisco, Lean Startup New York
    When I go to the list of groups
    Then I should see "Lean Startup Circle San Francisco"
    And I should see "Lean Startup New York"

  Scenario: Only approved groups show
    Given there is an approved group named Lean San Fran
    And there is a group named Lean NY
    When I go to the list of groups
    Then I should see "Lean San Fran"
    And I should not see "Lean NY"

  Scenario: Display name with link
    Given there is a group with attributes:
        | name           | meetup_link          | approval | city     |
        | Lean San Fran  | http://blah.com/blah | true     | New York |
    When I go to the list of groups
    And I click "Lean San Fran" within "table"
    Then I should be redirected to "http://blah.com/blah"

  Scenario: Display location
    Given there is a group with attributes:
        | name           | city          | province | country       | approval |
        | Lean San Fran  | San Francisco | CA       | United States | true     |
    When I go to the list of groups
    Then I should see "San Francisco, CA, United States"

  Scenario: Display Twitter link
    Given there is a group with attributes:
        | name           | twitter_link         | approval | city     |
        | Lean San Fran  | http://blah.com/blah | true     | New York |
    When I go to the list of groups
    And I click the image "link_twitter"
    Then I should be redirected to "http://blah.com/blah"

  Scenario: Display Google+ link
    Given there is a group with attributes:
        | name           | googleplus_link      | approval | city     |
        | Lean San Fran  | http://blah.com/blah | true     | New York |
    When I go to the list of groups
    And I click the image "link_googleplus"
    Then I should be redirected to "http://blah.com/blah"

  Scenario: Display Meetup link
    Given there is a group with attributes:
        | name           | meetup_link          | approval | city     |
        | Lean San Fran  | http://blah.com/blah | true     | New York |
    When I go to the list of groups
    And I click the image "link_meetup"
    Then I should be redirected to "http://blah.com/blah"

  Scenario: Display LinkedIn link
    Given there is a group with attributes:
        | name           | linkedin_link        | approval | city     |
        | Lean San Fran  | http://blah.com/blah | true     | New York |
    When I go to the list of groups
    And I click the image "link_linkedin"
    Then I should be redirected to "http://blah.com/blah"

  Scenario: Display Facebook link
    Given there is a group with attributes:
        | name           | facebook_link        | approval | city     |
        | Lean San Fran  | http://blah.com/blah | true     | New York |
    When I go to the list of groups
    And I click the image "link_facebook"
    Then I should be redirected to "http://blah.com/blah"
