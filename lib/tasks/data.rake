# frozen_string_literal: true

require 'net/http'
require 'fileutils'
require 'zip'
require 'csv'

namespace :data do
  Zip.on_exists_proc = true

  desc 'Fetches data files from original source'
  task :fetch do
    FileUtils.mkdir_p 'data'
    Net::HTTP.start('www.unece.org') do |http|
      resp = http.get('/fileadmin/DAM/cefact/locode/loc182csv.zip')
      open('data/loc182csv.zip', 'wb') do |file|
        file.write(resp.body)
      end
    end
    Zip::File.open('data/loc182csv.zip') do |zipfile|
      zipfile.each { |entry| entry.extract("data/#{entry.name}")}
    end
  end

  desc 'Insert data'
  task :insert do
    DB = Sequel::DATABASES.first || Sequel.connect(Environment.db_config)
    DB.run 'truncate table hubs_raw, hubs, countries, functions'

    rows = []
    [1, 2, 3].each do |number|
      CSV.parse(File.open("data/2018-2 UNLOCODE CodeListPart#{number}.csv", encoding: 'cp1252'){|f| f.read}, col_sep: ',') do |row|
        rows << row
      end
    end
    DB[:hubs_raw].import(
      %i[change country location name namewodiacritics subdivision function status date iata coordinates remarks],
      rows,
    )

    DB.run <<~SQL
      UPDATE hubs_raw SET coordinates = '4427N 06425W' WHERE country = 'CA' AND location = 'BHH';
      UPDATE hubs_raw SET coordinates = '4312N 08006W' WHERE country = 'CA' AND location = 'JSS';
      UPDATE hubs_raw SET coordinates = '2444N 05045E' WHERE country = 'SA' AND location = 'SAL';
      INSERT INTO hubs (country_id, location, name, function, coordinates)
        SELECT
            country,
            location,
            name,
            regexp_split_to_array(replace(function, '-', ''), ''),
            CASE WHEN coordinates <> '' THEN point(
                (CAST(SUBSTRING(coordinates from 1 for 2) as FLOAT) + CAST(SUBSTRING(coordinates from 3 for 2) as FLOAT)/60) * CASE WHEN SUBSTRING(coordinates from 5 for 1) = 'N' THEN 1 ELSE -1 END,
                (CAST(SUBSTRING(coordinates from 7 for 3) as FLOAT) + CAST(SUBSTRING(coordinates from 10 for 2) as FLOAT)/60) * CASE WHEN SUBSTRING(coordinates from 12 for 1) = 'E' THEN 1 ELSE -1 END
            ) ELSE NULL
            END
        FROM hubs_raw where location <> '';

      INSERT INTO countries (id, name)
        SELECT country, initcap(trim(leading '.' from name))
        FROM hubs_raw
        WHERE location IS NULL
        AND function IS NULL
        ORDER BY country;
    SQL
    functions = [
      ['0', 'Function not known, to be specified'],
      ['1', 'Port, as defined in Rec 16'],
      ['2', 'Rail Terminal'],
      ['3', 'Road Terminal'],
      ['4', 'Airport'],
      ['5', 'Postal Exchange Office'],
      ['6', 'Multimodal Functions (ICDs, etc'],
      ['7', 'Fixed Transport Functions (e.g. Oil platform'],
      ['8', 'Inland Port'],
      ['B', 'Border Crossing'],
    ]
    DB[:functions].import(%i[id name], functions)
  end
end
