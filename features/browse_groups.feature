Feature: View Groups
  Alice wants to browse a directory of groups and find out more information about them

  @javascript
  Scenario: Groups list
    Given there are groups named Lean Startup Circle San Francisco, Lean Startup New York
    When I go to the list of groups
    Then I should see "Lean Startup Circle San Francisco"
    And I should see "Lean Startup New York"

  @javascript
  Scenario: Only approved groups show
    Given there is a group with attributes:
        | name           | approval |
        | Lean San Fran  | true     |
        | Lean NY        | false    |
    When I go to the list of groups
    Then I should see "Lean San Fran"
    And I should not see "Lean NY"

  @javascript
  Scenario: Display name with link
    Given there is a group with attributes:
        | name           | meetup_link          | approval |
        | Lean San Fran  | http://blah.com/blah | true     |
    When I go to the list of groups
    And I click "Lean San Fran"
    Then I should be on "http://blah.com/blah"

  @javascript
  Scenario: Display location
    Given there is a group with attributes:
        | name           | city          | province | country       | approval |
        | Lean San Fran  | San Francisco | CA       | United States | true     |
    When I go to the list of groups
    Then I should see "San Francisco, CA, United States"

  @javascript
  Scenario: Display Twitter link
    Given there is a group with attributes:
        | name           | twitter_link         | approval |
        | Lean San Fran  | http://blah.com/blah | true     |
    When I go to the list of groups
    And I click the image "link_twitter"
#    TODO: Write a step to click on an image. Remember to compensate for the asset pipeline!
    Then I should be on "http://blah.com/blah"

  @javascript
  Scenario: Display Google+ link
    Given there is a group with attributes:
        | name           | googleplus_link      | approval |
        | Lean San Fran  | http://blah.com/blah | true     |
    When I go to the list of groups
    Then I click on the image "link_googleplus"
    Then I should be on "http://blah.com/blah"

  @javascript
  Scenario: Display Meetup link
    Given there is a group with attributes:
        | name           | meetup_link          | approval |
        | Lean San Fran  | http://blah.com/blah | true     |
    When I go to the list of groups
    Then I click on the image "link_twitter"
    Then I should be on "http://blah.com/blah"

  @javascript
  Scenario: Display LinkedIn link
    Given there is a group with attributes:
        | name           | linkedin_link         | approval |
        | Lean San Fran  | http://blah.com/blah  | true     |
    When I go to the list of groups
    Then I click on the image "link_linkedin"
    Then I should be on "http://blah.com/blah"

  @javascript
  Scenario: Display Facebook link
    Given there is a group with attributes:
        | name           | facebook_link         | approval |
        | Lean San Fran  | http://blah.com/blah  | true     |
    When I go to the list of groups
    Then I click on the image "link_facebook"
    Then I should be on "http://blah.com/blah"