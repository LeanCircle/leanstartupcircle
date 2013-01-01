require 'spec_helper'

describe "authenticate via twitter" do
  context "using valid credentials" do
    before do
      OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(build :omniauth_hash)
    end

    it "should be able to log in" do
      login_with_oauth
      page.should have_content("Sign out")
      page.should have_content("Fred")
      # TODO: Fix the following line. It sees the notice, but not the text???
      #page.should have_selector ".notice", :text => "Signed in"
    end

    it "should be able to log out" do
      login_with_oauth
      click_link 'Sign out'
      visit "/team"
      page.should have_content("Sign in")
      # TODO: Fix the following line. It sees the notice, but not the text???
      #page.should have_selector ".notice", :text => "Signed out"
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
      page.should have_selector ".alert", text: "Invalid credentials"
    end
  end
end