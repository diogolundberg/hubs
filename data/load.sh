psql -h localhost -U postgres -d hubs_development -c "truncate table hubs_raw"
psql -h localhost -U postgres -d hubs_development -c "truncate table hubs"
psql -h localhost -U postgres -d hubs_development -c "truncate table countries"
psql -h localhost -U postgres -d hubs_development -c "truncate table functions"

psql -h localhost -U postgres -d hubs_development -c "\copy hubs_raw (change, country, location, name, namewodiacritics, subdivision, function, status, date, iata, coordinates, remarks) from STDIN DELIMITER ',' CSV ENCODING 'windows-1252'" < data/'2018-2 UNLOCODE CodeListPart1.csv'
psql -h localhost -U postgres -d hubs_development -c "\copy hubs_raw (change, country, location, name, namewodiacritics, subdivision, function, status, date, iata, coordinates, remarks) from STDIN DELIMITER ',' CSV ENCODING 'windows-1252'" < data/'2018-2 UNLOCODE CodeListPart2.csv'
psql -h localhost -U postgres -d hubs_development -c "\copy hubs_raw (change, country, location, name, namewodiacritics, subdivision, function, status, date, iata, coordinates, remarks) from STDIN DELIMITER ',' CSV ENCODING 'windows-1252'" < data/'2018-2 UNLOCODE CodeListPart3.csv'

psql -h localhost -U postgres -d hubs_development -c "UPDATE hubs_raw SET coordinates = '4427N 06425W' WHERE country = 'CA' AND location = 'BHH';"
psql -h localhost -U postgres -d hubs_development -c "UPDATE hubs_raw SET coordinates = '4312N 08006W' WHERE country = 'CA' AND location = 'JSS';"
psql -h localhost -U postgres -d hubs_development -c "UPDATE hubs_raw SET coordinates = '2444N 05045E' WHERE country = 'SA' AND location = 'SAL';"

psql -h localhost -U postgres -d hubs_development -c "
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
FROM hubs_raw where location <> '';"

psql -h localhost -U postgres -d hubs_development -c "
INSERT INTO countries (id, name)
SELECT country, initcap(trim(leading '.' from name))
FROM hubs_raw
WHERE location IS NULL
AND function IS NULL
ORDER BY country;"


psql -h localhost -U postgres -d hubs_development -c "
INSERT INTO functions (id, name) VALUES
    ('0', 'Function not known, to be specified'),
    ('1', 'Port, as defined in Rec 16'),
    ('2', 'Rail Terminal'),
    ('3', 'Road Terminal'),
    ('4', 'Airport'),
    ('5', 'Postal Exchange Office'),
    ('6', 'Multimodal Functions (ICDs, etc'),
    ('7', 'Fixed Transport Functions (e.g. Oil platform'),
    ('8', 'Inland Port'),
    ('B', 'Border Crossing');"
