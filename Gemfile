source 'https://rubygems.org'

gem 'rails', '3.2.2'

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
end

group :test, :development do
  gem 'rspec-rails'
  gem 'watchr'
end