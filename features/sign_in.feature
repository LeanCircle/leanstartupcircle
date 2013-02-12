@without_geocode
Feature: Sign in
  Alice already has an account
  and should be able to sign in
  
  Background:
    Given There is a user named "Fred Flintstone"
    And I am not signed in

  Scenario: Get to Sign in page from home page
    Given I am on the home page
    And I click "Sign in"
    Then I should be on the sign in page

  Scenario: Get to Sign in page from another page
    Given I am on the team page
    And I click "Sign in"
    Then I should be on the sign in page

  @omniauth_test
  Scenario: Sign in with LinkedIn
    When I login with linkedin
    Then I should see "Sign out"
    And I should see "Welcome Fred"

  @omniauth_test
  Scenario: Sign in with Twitter and provide email
    When I login with twitter
    Then I should be on the sign up page
    When I fill in "Email" with "Test@test.com" within user
    And I fill in "Zip code" with "94110" within user
    And I press "Sign Up"
    Then I should see "Sign out"
    And I should see "Welcome Fred"

  @omniauth_test
  Scenario: Sign in with Meetup and provide email
    When I login with meetup
    Then I should be on the sign up page
    When I fill in "Email" with "Test@test.com" within user
    And I fill in "Zip code" with "94110" within user
    And I press "Sign Up"
    Then I should see "Sign out"
    And I should see "Welcome Fred"

  Scenario: Sign in with username and password
    Given I have an account as folowing:
      | name            | email         | password   |
      | Fred Flintstone | Test@test.com | 1234567890 |
    When I am on the sign in page
    When I fill in "Email" with "Test@test.com" within user
    And I fill in "Password" with "1234567890" within user
    And I press "Sign In"
    Then I should see "Sign out"
    And I should see "Welcome Fred"