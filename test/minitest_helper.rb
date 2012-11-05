ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/autorun'
require 'minitest/pride'
require 'database_cleaner'
# require 'mocha'

DatabaseCleaner.strategy = :truncation

class MiniTest::Spec
  include ActiveSupport::Testing::SetupAndTeardown
  # include ActiveRecord::TestFixtures

  alias :method_name :__name__ if defined? :__name__
  # self.fixture_path = File.join(Rails.root, 'test', 'fixtures')

  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end
end

class ControllerSpec < MiniTest::Spec
  include Rails.application.routes.url_helpers
  include ActionController::TestCase::Behavior

  class << self
    alias :context :describe
  end

  before do
    @routes = Rails.application.routes
  end
end

# Functional tests = describe ***Controller
MiniTest::Spec.register_spec_type( /Controller$/, ControllerSpec )

class AcceptanceSpec < MiniTest::Spec
  include Rails.application.routes.url_helpers
  # include Capybara::DSL

  before do
    @routes = Rails.application.routes
  end
end

# Integration/Acceptance tests = describe '*** Integration'
MiniTest::Spec.register_spec_type( /Integration$/, AcceptanceSpec )