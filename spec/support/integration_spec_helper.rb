module IntegrationSpecHelper
  def login_with_oauth(service = :twitter)
    visit "/users/auth/#{service}"
  end
end