Leanstartupcircle::Application.routes.draw do

  # Devise routes
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  devise_scope :user do
    get "sign_in", :to => "devise/sessions#new", :as => :sign_in
    delete "sign_out", :to => "devise/sessions#destroy", :as => :sign_out
  end

  # Jobs routes
  constraints :subdomain => "jobs" do
    match "/" => "landing_pages#jobs", :as => :jobs
    match "/users/employer_sign_up" => "users#employer_sign_up"
    match "/users/jobseeker_sign_up" => "users#jobseeker_sign_up"
    match "/users/register" => "users#register"
    match "/thanks_for_signing_up" => "landing_pages#thanks_for_signing_up"
    match "/thanks_for_applying" => "landing_pages#thanks_for_applying"
  end

  # Meetup routes
  constraints :subdomain => "meetups" do
    resources :meetups, :except => [:edit, :update, :destroy], :path => "/"
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
    resources :meetups
    resources :users
    resources :authentications, :only => [:index, :destroy]
  end

  root :to => "landing_pages#home"

end