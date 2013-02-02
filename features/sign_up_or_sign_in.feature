Feature: Sign up or Sign in
  In order to use advanced features
  Alice should be able to create an account and sign in

  @omniauth
  Scenario: Sign up with LinkedIn
    Given I am on the home page
    And I click "Sign up"
    Then I should be on the sign up page

    # Test is breaking here. I suspect it's because omniauth is not correctly stubbed. See features/support/omniauth.rb
    And I click "sign_up_with_linkedin"

    Then I should be on the home page
    And I should see "Sign out"