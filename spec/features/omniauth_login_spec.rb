require 'spec_helper'

describe "authenticate with twitter" do
  context "using valid credentials" do
    before do
      OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(build :omniauth_hash)
    end

    it "should be able to log in" do
      login_with_oauth
      page.should have_content("Sign out")
      page.should have_content("Fred")
    end

    it "should be able to log out" do
      login_with_oauth
      click_link 'Sign out'
      visit "/team"
      page.should have_content("Sign in")
    end
  end

  context "using invalid credentials", :js => true do
    before do
      OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
    end

    it "should not be able to log in" do
      login_with_oauth
      page.should_not have_content("Sign out")
      page.should have_content("Sign in")
      page.should have_content("Could not authenticate you from")
      page.should have_content("Invalid credentials")
    end
  end
end