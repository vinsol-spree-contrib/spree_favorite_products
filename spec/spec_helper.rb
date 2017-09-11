# Run Coverage report
require 'simplecov'
require 'minitest/autorun'

SimpleCov.start 'rails'

ENV['RAILS_ENV'] = 'test'

require File.expand_path('../dummy/config/environment.rb',  __FILE__)

require 'rspec/rails'
require 'database_cleaner'
require 'ffaker'
require 'shoulda-matchers'
require 'rspec-activemodel-mocks'
require 'rails-controller-testing'
require 'spree/testing_support/controller_requests'
require 'spree/testing_support/authorization_helpers'
require 'spree/testing_support/url_helpers'
require 'spree/testing_support/preferences'

# Requires factories defined in lib/spree_favorite_products/factories.rb
# require 'spree_favorite_products/factories'
Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include Spree::TestingSupport::UrlHelpers
  config.include Spree::TestingSupport::Preferences
  config.include Spree::TestingSupport::ControllerRequests, type: :controller
  config.include Spree::Core::Engine.routes.url_helpers
  config.include Devise::Test::ControllerHelpers, type: :controller

  config.mock_with :rspec
  config.color = true

  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.expose_current_running_example_as :example

  config.fail_fast = ENV['FAIL_FAST'] || false
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :active_record
    with.library :active_model
    with.library :action_controller
  end
end
