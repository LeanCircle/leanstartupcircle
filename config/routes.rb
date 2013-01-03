Leanstartupcircle::Application.routes.draw do

  # Jobs routes
  match "jobs" => "landing_pages#jobs", :as => :jobs
  match "jobs/users/employer_sign_up" => "users#employer_sign_up"
  match "jobs/users/jobseeker_sign_up" => "users#jobseeker_sign_up"
  match "jobs/users/register" => "users#register"
  match "jobs/thanks_for_signing_up" => "landing_pages#thanks_for_signing_up"
  match "jobs/thanks_for_applying" => "landing_pages#thanks_for_applying"

  # User routes
  resources :users, :only => [:index, :show]

  # Devise routes
  devise_for :users, :controllers => { :omniauth_callbacks => "my_devise/omniauth_callbacks", :registrations => "my_devise/registrations" }, :skip => [:sessions]
  as :user do
    get "sign_in", :to => "devise/sessions#new", :as => :sign_in
    get "sign_in_again", :to => "devise/sessions#new", :as => :user_session
    get "sign_up", :to => "my_devise/registrations#new", :as => :sign_up
    post "sign_in", :to => "devise/sessions#create", :as => :new_user_session
    delete "sign_out", :to => "devise/sessions#destroy", :as => :sign_out
  end

  # Group routes
  resources :groups, :except => [:edit, :update, :destroy] do
    get :organizers, :on => :collection
  end

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

  # Sitemaps
  match 'sitemap.xml' => 'sitemaps#sitemap'

  # Admin
  namespace :admin do
    match "/" => "base#dashboard", :as => :admin_dashboard
    resources :groups
    resources :users do
      get :imitate
    end
    resources :authentications, :only => [:index, :destroy]

  end

  root :to => "landing_pages#home"
end