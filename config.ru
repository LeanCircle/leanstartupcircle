# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
require './config/initializers/gollum.rb'
# - Make sinatra play nice
use Rack::MethodOverride
disable :run, :reload
 
 
# Mapping
# -------
 
# Rest with Rails
map "/" do
  run Leanstartupcircle::Application
end
 
# Anything urls starting with /slim will go to Sinatra
map "/wiki" do
 
  # make sure :key and :secret be in-sync with initializers/secret_store.rb initializers/secret_token.rb
  use Rack::Session::Cookie, :key => '_common_session_id', :secret => 'ogAnckUptujravAcsojbyilciawloupDatuckuld'
 
  # Point Warden to the Sinatra App
  use Warden::Manager do |manager|
    manager.failure_app = AppMain
    manager.default_scope = Devise.default_scope
  end
   
  # Borrowed from https://gist.github.com/217362
  Warden::Manager.before_failure do |env, opts|
    env['REQUEST_METHOD'] = "POST"
  end
 
  run AppMain
end