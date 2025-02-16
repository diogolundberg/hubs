# frozen_string_literal: true

source 'https://rubygems.org'
ruby '3.4.2'

gem 'dry-schema'
gem 'puma'
gem 'rack'
gem 'rack-reducer'
gem 'rack-unreloader'
gem 'roda'
gem 'sequel'
gem 'sequel_pg', require: 'sequel'

group :development do
  gem 'rubocop', require: false
  gem 'solargraph'
  gem 'rubyzip'
end

group :development, :test do
  gem 'rake'
  gem 'rspec'
end

group :test do
  gem 'database_cleaner-sequel'
  gem 'rack-test'
end
