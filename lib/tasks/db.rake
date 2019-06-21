# frozen_string_literal: true

namespace :db do
  task :setup do
    DB = Sequel::DATABASES.first || Sequel.connect(Environment.db_config)
  end

  desc 'Create database'
  task :create do
    config = Environment.db_config

    Sequel.connect(config.merge(database: 'postgres')) do |db|
      db.execute("CREATE DATABASE #{config[:database]}")
    end
  end

  desc 'Drop database'
  task :drop do
    config = Environment.db_config

    Sequel.connect(config.merge(database: 'postgres')) do |db|
      db.execute("DROP DATABASE IF EXISTS #{config[:database]}")
    end
  end

  desc 'Print current database schema version'
  task version: :setup do
    version =
      if DB.tables.include?(:schema_info)
        DB[:schema_info].order(:version).last[:version]
      else
        'not available'
      end

    puts "Current schema version: #{version}"
  end

  desc 'Run migrations'
  task migrate: :setup do
    Sequel.extension :migration
    Sequel::Migrator.run(DB, 'db/migrations')
    Rake::Task['db:version'].execute
  end
end
