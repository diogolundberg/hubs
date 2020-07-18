# frozen_string_literal: true

require 'csv'

Sequel.migration do
  up do
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
  end

  down { DB[:hubs_raw].truncate }
end
