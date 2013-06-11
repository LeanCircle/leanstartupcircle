class MyDevise::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    user, auth = User.find_or_create_with_omniauth!(request.env["omniauth.auth"], current_user)
    if current_user.present? && !auth.groups.blank?
      user.groups << auth.groups unless auth.groups.blank?
      flash.notice = "Your groups were imported." unless auth.groups.blank?
      redirect_to stored_location_for(:user) || root_path
    elsif request.env["omniauth.auth"].provider == "meetup" && !user.save
      session["auth"] = auth
      redirect_to :controller => 'my_devise/registrations', :action => 'provide_email'
    elsif user.save
      sign_in user
      group = Group.find(session["group_to_assign"]) if session["group_to_assign"].present?
      user.groups << group unless group.blank?
      user.groups << auth.groups unless auth.groups.blank?
      flash.notice = "You are now signed in!"
      flash.notice << " Your groups were imported" unless auth.groups.blank?
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