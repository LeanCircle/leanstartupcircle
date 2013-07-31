Leanstartupcircle::Application.routes.draw do
  get 'debug/index'
  get 'debug/signmein'

  # User routes
  resources :users, :only => [:index, :show]

  # Devise routes
  devise_for :users, :controllers => { :omniauth_callbacks => "my_devise/omniauth_callbacks", :registrations => "my_devise/registrations", :confirmations => "my_devise/confirmations" }, :skip => [:sessions]
  as :user do
    get "sign_in", :to => "devise/sessions#new", :as => :sign_in
    post "sign_in", :to => "devise/sessions#create", :as => :user_session
    get "sign_up", :to => "my_devise/registrations#new", :as => :sign_up
    post "sign_up", :to => "my_devise/registrations#create", :as => :user_registration
    post "sign_in_again", :to => "devise/sessions#create", :as => :new_user_session
    match "sign_out", :to => "devise/sessions#destroy", :as => :sign_out
    match "provide_email" => "my_devise/registrations#provide_email", :as => :provide_email
    get "user_confirmation", :to => "my_devise/confirmations#show", :as => :user_confirmation
  end

  # Group routes
  resources :groups, :except => [:edit, :update, :destroy] do
    get :organizers, :on => :collection
  end
  match "/metrics" => "groups#metrics", :as => :metrics

  # Events routes
  resources :events, :only => [:index]

  # Forum routes
  match "forum" => "forums#index", :as => :forum
  match "guidelines" => "forums#guidelines", :as => :guidelines
  match "guidelines_espanol" => "forums#guidelines_espanol", :as => :guidelines_espanol
  match "moderation_guidelines" => "forums#moderation_guidelines", :as => :moderation_guidelines
  match "faq.html" => "static_pages#guidelines"
  match "faq" => "static_pages#guidelines"

  # Static page routes
  [ :team].each do |static_page|
    match "/#{static_page}" => "static_pages##{static_page}", :as => static_page
  end

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

  mount Precious::App, at: '/wiki-leanstartup', :as => :gollum_wiki

  root :to => "landing_pages#home"
end
