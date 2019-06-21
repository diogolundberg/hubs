# frozen_string_literal: true

class Application < Roda
  plugin :multi_route
  plugin :json, classes: [Array, Hash, Sequel::Dataset]
  plugin :default_headers,
         'Access-Control-Allow-Origin' => '*',
         'Access-Control-Request-Method' => %w[GET OPTIONS].join(',')

  Unreloader.require('routes')

  route(&:multi_route)
end
