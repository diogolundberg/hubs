# hubs

```
docker run -d -p 5432:5432 postgres:alpine
rake db:create
rake db:migrate
rackup config.ru
```

### Dataset

- [UN/LOCODE by Country version](https://www.unece.org/fileadmin/DAM/cefact/locode/loc182csv.zip) - Source: [UNECE](http://www.unece.org/cefact/locode/welcome.html)

### Metadata

- Country codes - Source: [ISO 3166](https://www.iso.org/iso-3166-country-codes.html)
- Subdivision codes - Source: [ISO 3166-2](https://www.iso.org/iso-3166-country-codes.html)
- Function classifiers - Source: [UNECE](http://www.unece.org/cefact/locode/welcome.html)
- Status indicators - Source: [UNECE](http://www.unece.org/cefact/locode/welcome.html)

### Function classifiers

```
0 - Function not known, to be specified
1 - Port, as defined in Rec 16
2 - Rail Terminal
3 - Road Terminal
4 - Airport
5 - Postal Exchange Office
6 - Multimodal Functions (ICDs, etc.)
7 - Fixed Transport Functions (e.g. Oil platform)
8 - Inland Port
B - Border Crossing
```

[Postgres Geometric Types](https://www.postgresql.org/docs/current/datatype-geometric.html)
[Postgres Geometric Functions and Operators](https://www.postgresql.org/docs/current/functions-geometry.html)
[Postgres Earth distance](https://www.postgresql.org/docs/current/earthdistance.html)
