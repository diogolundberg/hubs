# frozen_string_literal: true

namespace :db do
  desc 'Drop database'
  task :drop do
    config = Environment.db_config

    Sequel.connect(config.merge(database: 'postgres')) do |db|
      db.execute("DROP DATABASE IF EXISTS #{config[:database]}")
    end
  end

  desc 'Print current database schema version'
  task version: :create do
    version =
      if database.tables.include?(:schema_info)
        database[:schema_info].order(:version).last[:version]
      else
        'not available'
      end

    puts "Current schema version: #{version}"
  end

  desc 'Run migrations'
  task :migrate do
    Sequel.extension(:migration)
    Sequel::Migrator.run(database, 'db/migrations')
    Rake::Task['db:version'].execute
  end

  def database
    config = Environment.db_config
    Sequel.connect(config)
  rescue Sequel::DatabaseConnectionError
    Sequel.connect(config.merge(database: 'postgres')) do |db|
      db.execute <<~SQL
        CREATE DATABASE #{config[:database]}
      SQL
    end
    Sequel.connect(config)
  end
end
