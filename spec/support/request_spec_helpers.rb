# frozen_string_literal: true

RSpec.configure do |config|
  config.include Rack::Test::Methods, type: :request
  config.include(Module.new do
    def response
      last_response
    end

    def json(str)
      JSON.parse(str)
    end
  end, type: :request,)
end
