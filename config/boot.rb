# frozen_string_literal: true

require_relative 'environment'
require_relative 'db'

Unreloader = Rack::Unreloader.new(
  subclasses: %w[Roda Sequel::Model],
  reload: Environment.development?,
) { Application }

Unreloader.require('config/application.rb')
Unreloader.require('models')
