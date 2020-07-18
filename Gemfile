# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.6.3'

gem 'dry-schema'
gem 'rack-reducer'
gem 'rack-unreloader'
gem 'roda'
gem 'sequel'
gem 'sequel_pg', require: 'sequel'

group :development do
  gem 'rubocop', require: false
  gem 'rubyzip'
end

group :development, :test do
  gem 'pry-byebug', require: 'pry'
  gem 'rake'
  gem 'rspec'
end

group :test do
  gem 'database_cleaner'
  gem 'rack-test'
end
