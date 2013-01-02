require 'spec_helper'

describe "authenticate via twitter" do
  context "using valid credentials" do
    before do
      OmniAuth.config.mock_auth[:linkedin] = OmniAuth::AuthHash.new(build :linkedin_hash)
      OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(build :twitter_hash)
      OmniAuth.config.mock_auth[:meetup] = OmniAuth::AuthHash.new(build :linkedin_hash)
    end

    context "should be able to log in" do
      it "with twitter" do
        login_with_oauth(:twitter)
        page.should have_content("Sign out")
        page.should have_content("Fred")
        # TODO: Fix the following line. It sees the notice, but not the text???
        #page.should have_selector ".notice", :text => "Signed in"
      end

      it "with linkedin" do
        login_with_oauth(:linkedin)
        page.should have_content("Sign out")
        page.should have_content("Fred")
        # TODO: Fix the following line. It sees the notice, but not the text???
        #page.should have_selector ".notice", :text => "Signed in"
      end
    end

    it "log out" do
      login_with_oauth(:twitter)
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