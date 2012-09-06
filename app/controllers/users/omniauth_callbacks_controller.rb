class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def jobseeker_sign_in
    session[:user_type] = :jobseeker
    redirect_to user_omniauth_authorize_path(:linkedin)
  end

  def employer_sign_in
    session[:user_type] = :employer
    redirect_to user_omniauth_authorize_path(:linkedin)
  end

  def linkedin
    @user = User.find_for_linkedin_oauth(request.env["omniauth.auth"])
    if @user == nil
      @user = User.create_from_linkedin_oauth(request.env["omniauth.auth"], session[:user_type])
    end
    sign_in @user, :event => :authentication
    redirect_to users_sign_up_path
  end
end
