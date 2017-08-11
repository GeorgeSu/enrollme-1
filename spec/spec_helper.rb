require 'support/controller_helpers'
require 'capybara/rspec'

if ENV['CI']
  require 'codeclimate-test-reporter'
  SimpleCov.start 'rails' do
    add_filter '/coverage/'
  end
else
  require 'simplecov'
  SimpleCov.start 'rails' do
    add_filter '/coverage/'
  end
end

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'factory_girl_rails'
#require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.include(OmniauthMacros)
  # Load seeds before all specs
  config.before(:each) do
    load 'db/seeds.rb'
  end
end

OmniAuth.config.test_mode = true


