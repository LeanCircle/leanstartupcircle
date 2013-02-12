@javascript
Feature: View Groups
  Alice wants to explore an interactive google map of groups.

  Scenario: Groups have small map pins
    Given there is an approved group named Lean Startup Circle
    When I go to the list of groups
    Then I should see a small map pin

  Scenario: LSC groups have large map pins
    Given there is an approved lsc group named Lean Startup Circle
    When I go to the list of groups
    Then I should see a large map pin

  Scenario: Only approved groups show
    Given there is a group named Lean NY
    When I go to the list of groups
    Then I should not see "Lean San Fran" within ".map_container"

  Scenario: Groups within 50 miles have red map pins
    Given there is a group with attributes:
        | name           | city          | province | country       | approval |
        | Lean San Fran  | San Francisco | CA       | United States | true     |
    And I am located in San Francisco
    When I go to the list of groups
    Then I should see a red map pin

  Scenario: Groups outside of 50 miles have orange map pins
    Given there is a group with attributes:
        | name           | city          | province | country       | approval |
        | Lean San Fran  | New York      | NY       | United States | true     |
    And I am located in San Francisco
    When I go to the list of groups
    Then I should see a orange map pin

  Scenario: Click on map pin to display name with link
    Given there is a group with attributes:
        | name           | meetup_link          | approval | city     |
        | Lean San Fran  | http://blah.com/blah | true     | New York |
    When I go to the list of groups
    And I click the map pin
    And I click "Lean San Fran" within ".map_container"
    Then I should be redirected to "http://blah.com/blah"

  Scenario: Click on map pin to display location
    Given there is a group with attributes:
        | name           | city          | province | country       | approval |
        | Lean San Fran  | San Francisco | CA       | United States | true     |
    When I go to the list of groups
    And I click the map pin
    Then I should see "San Francisco, CA, United States"

  Scenario: Click on map pin to display Twitter link
    Given there is a group with attributes:
        | name           | twitter_link         | approval | city     |
        | Lean San Fran  | http://blah.com/blah | true     | New York |
    When I go to the list of groups
    And I click the map pin
    And I click the image "link_twitter" within ".map_container"
    Then I should be redirected to "http://blah.com/blah"

  Scenario: Click on map pin to display Google+ link
    Given there is a group with attributes:
        | name           | googleplus_link      | approval | city     |
        | Lean San Fran  | http://blah.com/blah | true     | New York |
    When I go to the list of groups
    And I click the map pin
    And I click the image "link_googleplus" within ".map_container"
    Then I should be redirected to "http://blah.com/blah"

  Scenario: Click on map pin to display Meetup link
    Given there is a group with attributes:
        | name           | meetup_link          | approval | city     |
        | Lean San Fran  | http://blah.com/blah | true     | New York |
    When I go to the list of groups
    And I click the map pin
    And I click the image "link_meetup" within ".map_container"
    Then I should be redirected to "http://blah.com/blah"

  Scenario: Click on map pin to display LinkedIn link
    Given there is a group with attributes:
        | name           | linkedin_link        | approval | city     |
        | Lean San Fran  | http://blah.com/blah | true     | New York |
    When I go to the list of groups
    And I click the map pin
    And I click the image "link_linkedin" within ".map_container"
    Then I should be redirected to "http://blah.com/blah"

  Scenario: Click on map pin to display Facebook link
    Given there is a group with attributes:
        | name           | facebook_link        | approval | city     |
        | Lean San Fran  | http://blah.com/blah | true     | New York |
    When I go to the list of groups
    And I click the map pin
    And I click the image "link_facebook" within ".map_container"
    Then I should be redirected to "http://blah.com/blah"