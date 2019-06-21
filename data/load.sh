psql -h localhost -U postgres -d hubs_development -c "\copy hubs_raw (change, country, location, name, namewodiacritics, subdivision, function, status, date, iata, coordinates, remarks) from STDIN DELIMITER ',' CSV ENCODING 'windows-1252'" < data/'2018-2 UNLOCODE CodeListPart1.csv'
psql -h localhost -U postgres -d hubs_development -c "\copy hubs_raw (change, country, location, name, namewodiacritics, subdivision, function, status, date, iata, coordinates, remarks) from STDIN DELIMITER ',' CSV ENCODING 'windows-1252'" < data/'2018-2 UNLOCODE CodeListPart2.csv'
psql -h localhost -U postgres -d hubs_development -c "\copy hubs_raw (change, country, location, name, namewodiacritics, subdivision, function, status, date, iata, coordinates, remarks) from STDIN DELIMITER ',' CSV ENCODING 'windows-1252'" < data/'2018-2 UNLOCODE CodeListPart3.csv'

psql -h localhost -U postgres -d hubs_development -c "
INSERT INTO hubs (country_id, location, name, function, coordinates)
SELECT
    country,
    location,
    name,
    regexp_split_to_array(replace(function, '-', ''), ''),
    nullif(coordinates, '')
FROM hubs_raw where location <> '';"

psql -h localhost -U postgres -d hubs_development -c "
INSERT INTO countries (id, name)
SELECT country, initcap(trim(leading '.' from name))
FROM hubs_raw
WHERE location IS NULL
AND function IS NULL
ORDER BY country;"
