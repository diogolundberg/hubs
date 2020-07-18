# frozen_string_literal: true

Sequel.migration do
  up do
    run <<~SQL
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
    SQL
  end

  down { DB[:hubs].truncate }
end
