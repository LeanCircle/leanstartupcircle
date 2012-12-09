class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    user = User.authenticate_or_create_with_omniauth!(request.env["omniauth.auth"], current_user)
    if user.persisted?
      flash.notice = "Signed in!"
      sign_in user
      redirect_to stored_location_for(:user) || root_path
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end

  alias_method :linkedin, :all
  alias_method :meetup, :all
  alias_method :twitter, :all

end