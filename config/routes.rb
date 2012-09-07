Leanstartupcircle::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :user do
    match '/jobseeker_sign_in', :to => 'users/omniauth_callbacks#jobseeker_sign_in'
    match '/employer_sign_in', :to => 'users/omniauth_callbacks#employer_sign_in'
  end

  #root :to => redirect("https://groups.google.com/forum/?fromgroups#!forum/lean-startup-circle")

  # Jobs routes
  constraints(Subdomain) do
    match "/" => "landing_pages#jobs"
    match "/users/employer_sign_up" => "users#employer_sign_up"
    match "/users/jobseeker_sign_up" => "users#jobseeker_sign_up"
    match "/users/register" => "users#register"
    match "/thanks_for_signing_up" => "landing_pages#thanks_for_signing_up"
    match "/thanks_for_applying" => "landing_pages#thanks_for_applying"
  end
  match "/jobs" => "landing_pages#jobs"
  match "/users/employer_sign_up" => "users#employer_sign_up"
  match "/users/jobseeker_sign_up" => "users#jobseeker_sign_up"
  match "/users/register" => "users#register"
  match "/thanks_for_signing_up" => "landing_pages#thanks_for_signing_up"
  match "/thanks_for_applying" => "landing_pages#thanks_for_applying"

  # Static page routes
  [ :guidelines,
    :team,
    :moderation_guidelines].each do |static_page|
    match "/#{static_page}" => "static_pages##{static_page}", :as => static_page
  end
  match "faq.html" => "static_pages#guidelines"
  match "faq" => "static_pages#guidelines"

  # Contact message routes
  resources :contact_messages, :only => [:new, :create]
  match "/contact" => "contact_messages#new", :as => :contact
  match "/thanks_for_your_message" => "contact_messages#thanks", :as => :contact_thanks

  root :to => "landing_pages#home"

end