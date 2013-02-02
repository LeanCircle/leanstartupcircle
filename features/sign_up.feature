Feature: Sign up
  In order to use advanced features
  Alice should be able to create an account and sign in

  Scenario: Get to sign up page from home page
    Given I am on the home page
    And I click "Sign up"
    Then I should be on the sign up page

  Scenario: Get to sign up page from another page
    Given I am on the team page
    And I click "Sign up"
    Then I should be on the sign up page

  @omniauth
  Scenario: Sign up with LinkedIn
    Given There are no users
    And I am not signed in
    When I login with linkedin
    # Test is breaking. I suspect it's because omniauth is not correctly stubbed. See features/support/omniauth.rb
    Then I should see "Sign out"

  @omniauth
  Scenario: Sign up with Twitter and provide email
    Given There are no users
    And I am not signed in
    When I login with twitter
    Then I should be on the sign_up_page
    And I fill in "Email" with "Test@test.com"
    Then I should see "Sign out"

  @omniauth
  Scenario: Sign up with Meetup
    Given There are no users
    And I am not signed in
    When I login with meetup
    Then I should be on the sign_up_page
    And I fill in "Email" with "Test@test.com"
    And I press "Sign Up"
    Then I should see "Sign out"

  Scenario: Sign up with username and password
    Given There are no users
    And I am not signed in
    When I am on the sign up page
    And I fill in "Name" with "Bob Smith"
    And I fill in "Email" with "Test@test.com"
    And I fill in "Zip code" with "94110"
    And I fill in "Password" with "1234567890"
    And I press "Sign Up"
    Then I should see "Sign out"