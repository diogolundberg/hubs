# frozen_string_literal: true

Sequel.migration do
  up do
    run <<~SQL
      INSERT INTO countries (id, name)
      SELECT country, initcap(trim(leading '.' from name))
      FROM hubs_raw
      WHERE location IS NULL
      AND function IS NULL
      ORDER BY country;
    SQL
  end

  down { DB[:countries].truncate }
end
