@without_geocode
Feature: Sign up
  In order to use advanced features
  Alice should be able to create an account and sign in

  Background:
    Given There are no users
    And I am not signed in

  Scenario: Get to sign up page from home page
    Given I am on the home page
    And I click "Sign up"
    Then I should be on the sign up page

  Scenario: Get to sign up page from another page
    Given I am on the team page
    And I click "Sign up"
    Then I should be on the sign up page

  @omniauth_test
  Scenario: Sign up with LinkedIn
    When I login with linkedin
    Then I should see "Sign out"
    And I should see "Welcome Fred"

  @omniauth_test
  Scenario: Sign up with Twitter and provide email
    When I login with twitter
    Then I should be on the sign up page
    When I fill in "Email" with "Test@test.com" within user
    And I fill in "Zip code" with "94110" within user
    And I press "Sign Up"
    Then I should see "Sign out"
    And I should see "Welcome Fred"

  @omniauth_test
  Scenario: Sign up with Meetup and provide email
    When I login with meetup
    Then I should be on the sign up page
    When I fill in "Email" with "Test@test.com" within user
    And I fill in "Zip code" with "94110" within user
    And I press "Sign Up"
    Then I should see "Sign out"
    And I should see "Welcome Fred"

  Scenario: Sign up with username and password
    When I am on the sign up page
    And I fill in "Name" with "Bob Smith" within user
    And I fill in "Email" with "Test@test.com" within user
    And I fill in "Zip code" with "94110" within user
    And I fill in "Password" with "1234567890" within user
    And I press "Sign Up"
    Then I should see "Sign out"