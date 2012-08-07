class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def linkedin
    @user = User.find_for_linkedin_oauth(request.env["omniauth.auth"])
    if @user == nil
      @user = User.create_from_linkedin_oauth(request.env["omniauth.auth"])
    end
    sign_in @user, :event => :authentication
    redirect_to thanks_for_signing_up_url
  end
end