class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    user = User.authenticate_or_create_with_omniauth!(request.env["omniauth.auth"], current_user)
    if user.persisted?
      flash.notice = "Signed in!"
      sign_in_and_redirect user
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end

  alias_method :linkedin, :all
  alias_method :meetup, :all

end