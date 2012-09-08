class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def user_sign_in
    session[:user_type] = params[:user_type]
    redirect_to user_omniauth_authorize_path(:linkedin)
  end

  def linkedin
    @user = User.find_for_linkedin_oauth(request.env["omniauth.auth"])
    if @user == nil
      @user = User.create_from_linkedin_oauth(request.env["omniauth.auth"], session[:user_type])
    end

    sign_in @user, :event => :authentication

    if session[:user_type] == 'employer'
      redirect_to users_employer_sign_up_path
    else
      redirect_to users_jobseeker_sign_up_path
    end
  end

end