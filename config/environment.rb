# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Leanstartupcircle::Application.initialize!

Leanstartupcircle::Application.configure do
  config.action_controller.session = {
    :session_domain => 'leanstartupcircle.com',
    :session_key => '_leanstartupcircle',
    :secret      => AppConfig['secret_token']
  }
end