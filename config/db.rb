# frozen_string_literal: true

DB = Sequel::DATABASES.first || Sequel.connect(Environment.db_config)
DB.extension(:pagination)
Sequel::Model.plugin(:json_serializer)

if Environment.development?
  require 'logger'
  DB.loggers << Logger.new($stdout)
  Sequel::Model.cache_associations = false
end
