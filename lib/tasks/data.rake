# frozen_string_literal: true

require 'net/http'
require 'fileutils'
require 'zip'

namespace :data do
  Zip.on_exists_proc = true

  desc 'Fetches data files from original source'
  task :fetch do
    FileUtils.mkdir_p 'data'
    Net::HTTP.start('www.unece.org') do |http|
      resp = http.get('/fileadmin/DAM/cefact/locode/loc182csv.zip')
      puts resp
      open('data/loc182csv.zip', 'wb') do |file|
        file.write(resp.body)
      end
    end
    Zip::File.open('data/loc182csv.zip') do |zipfile|
      zipfile.each { |entry| entry.extract("data/#{entry.name}")}
    end
  end

  desc 'Run data migrations'
  task :migrate do
    session = Sequel::DATABASES.first || Sequel.connect(Environment.db_config)
    Sequel.extension(:migration)
    Sequel::Migrator.run(session, "db/data", table: :data_info)
  end
end
