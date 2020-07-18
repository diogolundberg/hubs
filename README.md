# hubs

## Stack

* [Roda](http://roda.jeremyevans.net/), a rack-based routing tree web toolkit
* [Sequel](http://sequel.jeremyevans.net/), a simple SQL database access toolkit

## Requirements

The following software is required to be installed locally in order to get this project running:

* Ruby
* Bundler
* Docker

## Run the project

```
bundle install
docker run -d -p 5432:5432 postgres:alpine
rake db:migrate
rake data:fetch
rake data:migrate
rackup config.ru
```

### Dataset

- [UN/LOCODE by Country version](https://www.unece.org/fileadmin/DAM/cefact/locode/loc182csv.zip) - Source: [UNECE](http://www.unece.org/cefact/locode/welcome.html)

### Metadata

- [Country codes](http://www.unece.org/cefact/locode/service/location.html) - Source: [ISO 3166](https://www.iso.org/iso-3166-country-codes.html)
- [Subdivision codes](http://www.unece.org/cefact/locode/service/location.html) - Source: [ISO 3166-2](https://www.iso.org/iso-3166-country-codes.html)

- [Function classifiers](http://www.unece.org/fileadmin/DAM/cefact/locode/UNLOCODE_Manual.pdf) - Source: [UNECE](http://www.unece.org/cefact/locode/welcome.html)
- [Status indicators](http://www.unece.org/fileadmin/DAM/cefact/locode/UNLOCODE_Manual.pdf) - Source: [UNECE](http://www.unece.org/cefact/locode/welcome.html)

###  Method used for Earth Distances
- [Postgres Geometric Types](https://www.postgresql.org/docs/current/datatype-geometric.html)
- [Postgres Geometric Functions and Operators](https://www.postgresql.org/docs/current/functions-geometry.html)
- [Postgres Earth distance](https://www.postgresql.org/docs/current/earthdistance.html)
