class MyDevise::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    user, auth = User.find_or_create_with_omniauth!(request.env["omniauth.auth"], current_user)
    if user.save
      sign_in user
      flash.notice = "Signed in!"
      redirect_to stored_location_for(:user) || root_path
    else
      session["auth"] = auth
      session["devise.user_attributes"] = user.attributes
      redirect_to :sign_up
    end
  end

  alias_method :linkedin, :all
  alias_method :meetup, :all
  alias_method :twitter, :all
end