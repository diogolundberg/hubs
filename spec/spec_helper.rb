# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require File.expand_path('../config/environment', __dir__)
require File.expand_path('../config/boot', __dir__)
Dir[File.join(__dir__, 'support/**/*.rb')].each(&method(:require))

RSpec.configure do |config|
  config.include(Module.new do
    def app
      Application.freeze.app
    end
  end)

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.disable_monkey_patching!
end
