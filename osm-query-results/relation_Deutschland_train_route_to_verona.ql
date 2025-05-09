[out:json][timeout:60];

area ["name"="Deutschland"] -> .myArea;
(
  relation (area.myArea) [ "type"="route" ]  [ "route"="train" ] ["name"~"Verona"] ;
);

out tags;

## result quite short:

{
  "version": 0.6,
  "generator": "Overpass API 0.7.62.5 1bd436f1",
  "osm3s": {
    "timestamp_osm_base": "2025-05-09T13:13:37Z",
    "timestamp_areas_base": "2025-02-06T02:17:44Z",
    "copyright": "The data included in this document is from www.openstreetmap.org. The data is made available under ODbL."
  },
  "elements": [

{
  "type": "relation",
  "id": 3654988,
  "tags": {
    "colour": "#FFA700",
    "from": "München Hbf",
    "name": "EC 83: München => Verona",
    "network": "DB InterCity;EuroCity;ÖBB",
    "operator": "DB Fernverkehr AG;ÖBB",
    "public_transport:version": "2",
    "ref": "EC 83",
    "route": "train",
    "service": "long_distance",
    "to": "Verona Porta Nuova",
    "type": "route"
  }
},
{
  "type": "relation",
  "id": 13059451,
  "tags": {
    "colour": "#FFA700",
    "from": "Verona Porta Nuova",
    "name": "EC 80: Verona => München",
    "network": "DB InterCity;EuroCity;ÖBB",
    "operator": "DB Fernverkehr AG;ÖBB",
    "public_transport:version": "2",
    "ref": "EC 80",
    "route": "train",
    "service": "long_distance",
    "to": "München Hbf",
    "type": "route"
  }
}

  ]
}
