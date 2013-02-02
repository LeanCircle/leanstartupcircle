# TODO: This does not seem to be working and/or unnecessary.

Before('@omniauth_test') do
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:linkedin] = OmniAuth::AuthHash.new(build :linkedin_hash)
  OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(build :twitter_hash)
  OmniAuth.config.mock_auth[:meetup] = OmniAuth::AuthHash.new(build :meetup_hash)
end

After('@omniauth_test') do
  OmniAuth.config.test_mode = false
end