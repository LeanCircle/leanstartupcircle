source 'https://rubygems.org'

gem 'rails', '3.2.11'

gem 'jquery-rails'
gem 'haml-rails'
gem 'pg'
gem 'json', '1.7.3'
#gem 'redis' # Use Redis for caching geocode info

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
gem 'dynamic_sitemaps'
gem 'figaro'

# Error notification
gem "airbrake"
gem 'newrelic_rpm'

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
  gem 'taps' # Allows pushing and pulling from heroku db.
  gem 'sqlite3'
  gem 'rails_best_practices'
  gem 'guard'
  gem 'spork'
end

group :test, :development do
  gem 'factory_girl_rails'
  gem 'shoulda'
  gem 'ruby-debug19', :require => 'ruby-debug'
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