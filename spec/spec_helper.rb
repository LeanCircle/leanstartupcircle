require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'ffaker'
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.use_transactional_fixtures = true
    config.infer_base_class_for_anonymous_controllers = false

    config.order = "random"
    config.mock_with :rspec
    config.include FactoryGirl::Syntax::Methods
    config.include IntegrationSpecHelper, :type => :feature
  end
end

Spork.each_run do
  # Anything to run between tests?
end