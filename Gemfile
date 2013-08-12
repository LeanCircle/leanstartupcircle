source 'https://rubygems.org'

gem 'rails', '~> 3.2.12'

gem 'jquery-rails'
gem 'haml-rails'
gem 'pg'
gem 'json', '1.7.3'
gem 'unicorn'
#gem 'redis' # Use Redis for caching geocode info
gem 'debugger'

# Authentication & Access control
gem 'devise'
gem 'omniauth'
gem 'omniauth-linkedin', :git => 'git://github.com/TriKro/omniauth-linkedin.git'
gem 'omniauth-meetup', :git => 'git://github.com/TriKro/omniauth-meetup.git'
gem 'omniauth-twitter'
gem 'cancan'
gem 'recaptcha', :require => 'recaptcha/rails'

# APIs
gem 'rmeetup', :git => 'git://github.com/pbajaria/rmeetup.git'
gem 'geocoder'
gem 'gmaps4rails'

# Miscellaneous
gem 'friendly_id'
gem "dynamic_sitemaps", "1.0.8"
gem 'figaro'

# Error notification
gem "airbrake"
gem 'newrelic_rpm'

# wiki
              # custom version of gollum to enable user authentication/authorization
gem 'gollum', :git => 'https://github.com/alexagui/gollum', :branch => 'v2.4.11-lsc' 
gem 'nokogiri', '1.5.5'  # lock nokogiri to 1.5.5 as our custom version of gollum requires it
gem 'wikicloth'

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'compass-rails'
end

group :development do
  gem 'nifty-generators' # Just using it for Ryan Bates stuff.
  gem 'heroku_san' # Awesome rake tasks for heroku, see: https://github.com/fastestforward/heroku_san
  gem 'awesome_print' # Use 'ap' in the console to make output comprehensible
  # gem 'taps' # Allows pushing and pulling from heroku db.
  gem 'sqlite3'
  #gem 'rails_best_practices'
  gem 'guard'
  gem 'guard-rails'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'guard-cucumber'
  gem 'guard-jasmine'
  gem 'guard-livereload'
  gem 'guard-haml'
  gem 'guard-coffeescript'
  gem 'guard-bundler'
  # gem 'guard-sass', :require => false

  # Non-required files to use operating system notifications to trigger guard
  gem 'rb-inotify', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-fchange', :require => false

  gem 'spork'
  gem 'growl' # Use growl for notifications

  gem 'capistrano-unicorn', :require => false
end

group :test, :development do
  gem 'factory_girl_rails'
  gem 'shoulda'
  # gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'capybara'
  gem 'capybara-webkit', :git => 'https://github.com/thoughtbot/capybara-webkit.git'
end

group :test do
  gem 'simplecov', :require => false
  gem 'rspec-rails'
  gem 'fakeweb'
  gem 'ffaker'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
end

