# frozen_string_literal: true

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)
require 'bundler/setup'

class Environment
  def self.bundle
    @bundle ||= ENV.fetch('RACK_ENV', 'development')
  end

  def self.development?
    bundle == 'development'
  end

  def self.production?
    bundle == 'production'
  end

  def self.db_config
    return ENV['DATABASE_URL'] if production?

    {
      adapter: ENV.fetch('DATABASE_ADAPTOR', 'postgres'),
      host: ENV.fetch('DATABASE_HOST', 'localhost'),
      database: ENV.fetch('DATABASE_DB', "hubs_#{bundle}"),
      username: ENV.fetch('DATABASE_USERNAME', 'postgres'),
      password: ENV['DATABASE_PASSWORD'],
    }
  end
end

Bundler.require(:default, Environment.bundle)
