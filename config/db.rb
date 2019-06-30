# frozen_string_literal: true

Sequel.extension(:core_extensions)
Sequel::Model.plugin(:json_serializer)
DB = Sequel::DATABASES.first || Sequel.connect(Environment.db_config)
DB.extension(:pagination)
DB.extension(:auto_literal_strings)

if Environment.development?
  require 'logger'
  DB.loggers << Logger.new($stdout)
  Sequel::Model.cache_associations = false
end
