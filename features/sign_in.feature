Feature: Sign in
  Alice already has an account
  and should be able to sign in

  Scenario: Get to Sign in page from home page
    Given I am on the home page
    And I click "Sign in"
    Then I should be on the Sign in page

  Scenario: Get to Sign in page from another page
    Given I am on the team page
    And I click "Sign in"
    Then I should be on the Sign in page

  @omniauth
  Scenario: Sign in with LinkedIn
    Given There is a user named "Fred Flintstone"
    # TODO: Write this given to generate the correct user for sign in

    And I am not signed in
    When I login with linkedin
    Then I should see "Sign out"
    And I should see "Welcome Fred"

  @omniauth
  Scenario: Sign in with Twitter and provide email
    Given There is a user named "Fred Flintstone"
    # TODO: Write this given to generate the correct user for sign in

    When I login with twitter
    Then I should see "Sign out"
    And I should see "Welcome Fred"

  @omniauth
  Scenario: Sign in with Meetup
    Given There is a user named "Fred Flintstone"
    # TODO: Write this given to generate the correct user for sign in

    When I login with meetup
    Then I should see "Sign out"
    And I should see "Welcome Fred"

  Scenario: Sign in with username and password
    Given I am not signed in
    When I am on the sign in page
    And I fill in "Email" with "Test@test.com"
    And I fill in "Password" with "1234567890"
    And I press "Sign In"
    Then I should see "Sign out"
    And I should see "Welcome Fred"