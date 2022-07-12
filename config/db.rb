# frozen_string_literal: true

Sequel.extension(:core_extensions)
Sequel::Model.plugin(:json_serializer)
session = Sequel::DATABASES.first || Sequel.connect(Environment.db_config)
session.extension(:pagination)
session.extension(:auto_literal_strings)

if Environment.development?
  require 'logger'
  session.loggers << Logger.new($stdout)
  Sequel::Model.cache_associations = false
end
