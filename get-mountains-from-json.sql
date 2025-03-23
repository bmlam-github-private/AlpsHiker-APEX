create table tmp_mountains_json AS 
SELECT jt.*
FROM JSON_TABLE ( 
q'[
{
	  "version": 0.6,
	  "generator": "Overpass API 0.7.62.4 2390de5a",
	  "osm3s": {
	    "timestamp_osm_base": "2025-01-18T15:14:23Z",
	    "timestamp_areas_base": "2025-01-18T13:25:16Z",
	    "copyright": "The data included in this document is from www.openstreetmap.org. The data is made available under ODbL."
	  },
	  "elements": 
[ 	
	{
	  "type": "node",
	  "id": 26863047,
	  "lat": 47.3973362,
	  "lon": 11.2223256,
	  "tags": {
	    "alt_name": "Große Ahrnspitze",
	    "description": "Große Arnspitze Signalgipfel",
	    "ele": "2196",
	    "name": "Große Arnspitze",
	    "natural": "peak",
	    "prominence": "993",
	    "wikidata": "Q1548141",
	    "wikipedia": "de:Große Arnspitze"
	  }
	},
	{
	  "type": "node",
	  "id": 26863176,
	  "lat": 47.5693262,
	  "lon": 12.8658126,
	  "tags": {
	    "ele": "2608",
	    "name": "Hochkalter",
	    "natural": "peak",
	    "ref:avf": "2050",
	    "summit:cross": "yes",
	    "wikidata": "Q883041"
	  }
	},
	{
	  "type": "node",
	  "id": 26863436,
	  "lat": 47.5265671,
	  "lon": 10.9180158,
	  "tags": {
	    "alt_name": "Ammergauer Kreuzspitze, Ammergauer Kreuzspitz",
	    "ele": "2184",
	    "name": "Kreuzspitze",
	    "natural": "peak",
	    "prominence": "1182",
	    "wikidata": "Q279725",
	    "wikipedia": "de:Kreuzspitze (Ammergauer Alpen)"
	  }
	},
	{
	  "type": "node",
	  "id": 26863440,
	  "lat": 47.5443752,
	  "lon": 11.1914281,
	  "tags": {
	    "ele": "2086",
	    "name": "Krottenkopf",
	    "natural": "peak",
	    "prominence": "1156",
	    "summit:cross": "yes",
	    "wikidata": "Q565442"
	  }
	},
	{
	  "type": "node",
	  "id": 27384190,
	  "lat": 47.4212150,
	  "lon": 10.9862970,
	  "tags": {
	    "alt_name": "Zugspitze (Ostgipfel)",
	    "ele": "2962",
	    "importance": "national",
	    "name": "Zugspitze",
	    "name:ja": "ツークシュピッツェ",
	    "natural": "peak",
	    "prominence": "1746",
	    "source:prominence": "2962-1216 (Fernpass)",
	    "summit:cross": "yes",
	    "wikidata": "Q3375",
	    "wikimedia_commons": "Category:Zugspitze",
	    "wikipedia": "de:Zugspitze"
	  }
	},
	{
	  "type": "node",
	  "id": 67233894,
	  "lat": 47.4815666,
	  "lon": 11.3571077,
	  "tags": {
	    "ele": "2253",
	    "man_made": "cross",
	    "name": "Soiernspitze",
	    "natural": "peak",
	    "summit:cross": "yes",
	    "wikidata": "Q316066",
	    "wikipedia": "de:Soiernspitze"
	  }
	},
	{
	  "type": "node",
	  "id": 256041673,
	  "lat": 47.4004814,
	  "lon": 11.1239474,
	  "tags": {
	    "alt_name": "Karlspitze",
	    "ele": "2682",
	    "name": "Leutascher Dreitorspitze",
	    "natural": "peak",
	    "wikidata": "Q585796",
	    "wikipedia": "de:Dreitorspitze"
	  }
	},
	{
	  "type": "node",
	  "id": 256041839,
	  "lat": 47.4300189,
	  "lon": 11.2988580,
	  "tags": {
	    "ele": "2385",
	    "name": "Westliche Karwendelspitze",
	    "natural": "peak",
	    "wikidata": "Q316308",
	    "wikipedia": "de:Westliche Karwendelspitze"
	  }
	},
	{
	  "type": "node",
	  "id": 256042768,
	  "lat": 47.4095968,
	  "lon": 10.9699595,
	  "tags": {
	    "ele": "2874",
	    "name": "Schneefernerkopf",
	    "natural": "peak",
	    "wikidata": "Q679080",
	    "wikimedia_commons": "Category:Schneefernerkopf",
	    "wikipedia": "de:Schneefernerkopf"
	  }
	},
	{
	  "type": "node",
	  "id": 259406948,
	  "lat": 47.4386941,
	  "lon": 11.0497130,
	  "tags": {
	    "ele": "2060",
	    "name": "Osterfelderkopf",
	    "natural": "peak",
	    "wikidata": "Q18560512"
	  }
	},
	{
	  "type": "node",
	  "id": 259486622,
	  "lat": 47.4294968,
	  "lon": 11.0478118,
	  "tags": {
	    "ele": "2628",
	    "name": "Alpspitze",
	    "natural": "peak",
	    "wikidata": "Q252743"
	  }
	},
	{
	  "type": "node",
	  "id": 277722457,
	  "lat": 47.5217533,
	  "lon": 10.9595715,
	  "tags": {
	    "ele": "2053",
	    "name": "Frieder",
	    "natural": "peak",
	    "summit:cross": "yes"
	  }
	},
	{
	  "type": "node",
	  "id": 277722495,
	  "lat": 47.5171414,
	  "lon": 10.9588323,
	  "tags": {
	    "ele": "2049",
	    "name": "Friederspitz",
	    "natural": "peak",
	    "summit:cross": "yes",
	    "wikidata": "Q315901"
	  }
	},
	{
	  "type": "node",
	  "id": 277727364,
	  "lat": 47.5092999,
	  "lon": 10.9163331,
	  "tags": {
	    "ele": "2052",
	    "name": "Schellschlicht",
	    "natural": "peak",
	    "ref:avf": "2596",
	    "summit:cross": "yes",
	    "summit:register": "yes",
	    "wikidata": "Q2233117"
	  }
	},
	{
	  "type": "node",
	  "id": 280328857,
	  "lat": 47.5414219,
	  "lon": 10.9425313,
	  "tags": {
	    "ele": "2020",
	    "name": "Kuchelbergspitze",
	    "natural": "peak",
	    "summit:cross": "yes",
	    "summit:register": "yes"
	  }
	},
	{
	  "type": "node",
	  "id": 280329639,
	  "lat": 47.5349169,
	  "lon": 10.9254312,
	  "tags": {
	    "ele": "2026",
	    "name": "Kuchelbergkopf",
	    "natural": "peak",
	    "wikidata": "Q31532992",
	    "wikipedia": "de:Kuchelbergkopf"
	  }
	},
	{
	  "type": "node",
	  "id": 284141671,
	  "lat": 47.4940798,
	  "lon": 11.3298011,
	  "tags": {
	    "alt_name": "Schöttlkarspitze",
	    "ele": "2050",
	    "name": "Schöttelkarspitze",
	    "natural": "peak",
	    "wikidata": "Q139309",
	    "wikipedia": "de:Schöttelkarspitze"
	  }
	},
	{
	  "type": "node",
	  "id": 286687475,
	  "lat": 47.4142547,
	  "lon": 11.1175579,
	  "tags": {
	    "alt_name": "Törl",
	    "ele": "2202",
	    "name": "Frauenalpl",
	    "natural": "peak",
	    "summit:cross": "yes",
	    "summit:register": "no"
	  }
	},
	{
	  "type": "node",
	  "id": 286790301,
	  "lat": 47.4310847,
	  "lon": 11.0603371,
	  "tags": {
	    "ele": "2144",
	    "fixme": "check location",
	    "name": "Bernadeinkopf",
	    "natural": "peak",
	    "wikidata": "Q822140"
	  }
	},
	{
	  "type": "node",
	  "id": 293247920,
	  "lat": 47.4279802,
	  "lon": 11.2930554,
	  "tags": {
	    "ele": "2372",
	    "name": "Nördliche Linderspitze",
	    "natural": "peak",
	    "wikidata": "Q15849891",
	    "wikipedia": "de:Linderspitzen"
	  }
	},
	{
	  "type": "node",
	  "id": 307562003,
	  "lat": 47.5584230,
	  "lon": 12.9237899,
	  "tags": {
	    "alt_name": "Watzmann-Hocheck",
	    "ele": "2651",
	    "historic": "wayside_cross",
	    "name": "Hocheck",
	    "natural": "peak",
	    "ref:avf": "2520",
	    "summit:cross": "yes",
	    "summit:register": "no",
	    "wikidata": "Q31354005"
	  }
	},
	{
	  "type": "node",
	  "id": 323842894,
	  "lat": 47.3963394,
	  "lon": 11.0397076,
	  "tags": {
	    "ele": "2548",
	    "name": "Kleiner Wanner",
	    "natural": "peak",
	    "wikidata": "Q21868517"
	  }
	},
	{
	  "type": "node",
	  "id": 323882896,
	  "lat": 47.5866422,
	  "lon": 13.0699972,
	  "tags": {
	    "ele": "2391",
	    "name": "Großer Archenkopf",
	    "natural": "peak",
	    "ref:avf": "2710",
	    "wikidata": "Q21871266"
	  }
	},
	{
	  "type": "node",
	  "id": 323896644,
	  "lat": 47.4175695,
	  "lon": 10.9723451,
	  "tags": {
	    "ele": "2815",
	    "name": "Zugspitzeck",
	    "natural": "peak",
	    "wikidata": "Q86980310",
	    "wikipedia": "de:Zugspitzeck"
	  }
	},
	{
	  "type": "node",
	  "id": 348139963,
	  "lat": 47.4269594,
	  "lon": 11.1910129,
	  "tags": {
	    "ele": "2297",
	    "name": "Obere Wettersteinspitze",
	    "natural": "peak",
	    "wikidata": "Q2566053",
	    "wikipedia": "de:Wettersteinspitzen"
	  }
	},
	{
	  "type": "node",
	  "id": 364134323,
	  "lat": 47.5543889,
	  "lon": 12.9220342,
	  "tags": {
	    "alt_name": "Watzmann",
	    "ele": "2713",
	    "name": "Watzmann-Mittelspitze",
	    "natural": "peak",
	    "ref:avf": "2530",
	    "summit:cross": "yes",
	    "summit:register": "yes",
	    "wikidata": "Q31306014"
	  }
	},
	{
	  "type": "node",
	  "id": 380969481,
	  "lat": 47.4377328,
	  "lon": 11.3212433,
	  "tags": {
	    "ele": "2430",
	    "name": "Tiefkarspitze",
	    "natural": "peak",
	    "note": "m ü. A.",
	    "wikidata": "Q21863490",
	    "wikipedia": "de:Tiefkarspitze"
	  }
	},
	{
	  "type": "node",
	  "id": 380989890,
	  "lat": 47.4056113,
	  "lon": 11.2872676,
	  "tags": {
	    "alt_name": "Brunnensteinspitze",
	    "ele": "2180",
	    "name": "Brunnsteinspitze",
	    "natural": "peak",
	    "summit:cross": "yes",
	    "summit:register": "no",
	    "wikidata": "Q2169131"
	  }
	},
	{
	  "type": "node",
	  "id": 387467327,
	  "lat": 47.5127249,
	  "lon": 12.8849252,
	  "tags": {
	    "ele": "2593",
	    "name": "Großer Hundstod",
	    "natural": "peak",
	    "ref:avf": "3460",
	    "summit:cross": "yes",
	    "wikidata": "Q565025",
	    "wikimedia_commons": "File:Grosser Hundstod south.JPG",
	    "wikipedia": "de:Großer Hundstod"
	  }
	},
	{
	  "type": "node",
	  "id": 387482195,
	  "lat": 47.6132271,
	  "lon": 12.8298043,
	  "tags": {
	    "ele": "2045",
	    "man_made": "cross",
	    "name": "Schottmalhorn",
	    "natural": "peak",
	    "wikidata": "Q828128"
	  }
	},
	{
	  "type": "node",
	  "id": 449389006,
	  "lat": 47.5488775,
	  "lon": 11.1852668,
	  "tags": {
	    "ele": "2049",
	    "name": "Oberer Rißkopf",
	    "natural": "peak",
	    "wikidata": "Q31529271"
	  }
	},
	{
	  "type": "node",
	  "id": 449491364,
	  "lat": 47.5404528,
	  "lon": 11.1757851,
	  "tags": {
	    "ele": "2033",
	    "name": "Bischof",
	    "natural": "peak",
	    "summit:cross": "yes",
	    "summit:register": "yes",
	    "wikidata": "Q866104"
	  }
	},
	{
	  "type": "node",
	  "id": 475537031,
	  "lat": 47.5480306,
	  "lon": 12.9169564,
	  "tags": {
	    "ele": "2712",
	    "name": "Watzmann-Südspitze",
	    "natural": "peak",
	    "old_name": "Schönfeldspitze",
	    "ref:avf": "2540",
	    "summit:cross": "yes",
	    "summit:register": "yes",
	    "wikidata": "Q31354390"
	  }
	},
	{
	  "type": "node",
	  "id": 476459617,
	  "lat": 47.5295856,
	  "lon": 12.9164520,
	  "tags": {
	    "alt_name": "Hirschwieskopf",
	    "ele": "2114",
	    "name": "Hirschwiese",
	    "natural": "peak",
	    "ref:avf": "2570",
	    "wikidata": "Q31354018"
	  }
	},
	{
	  "type": "node",
	  "id": 481694454,
	  "lat": 47.4898784,
	  "lon": 12.9672187,
	  "tags": {
	    "ele": "2446",
	    "name": "Stuhljoch",
	    "natural": "peak",
	    "ref:avf": "3360",
	    "wikidata": "Q31302513",
	    "wikipedia": "de:Funtenseetauern#Stuhljoch"
	  }
	},
	{
	  "type": "node",
	  "id": 496454912,
	  "lat": 47.4448563,
	  "lon": 11.4214330,
	  "tags": {
	    "ele": "2537",
	    "name": "Östliche Karwendelspitze",
	    "natural": "peak",
	    "prominence": "735",
	    "wikidata": "Q306927",
	    "wikipedia": "de:Östliche Karwendelspitze"
	  }
	},
	{
	  "type": "node",
	  "id": 504796020,
	  "lat": 47.5106761,
	  "lon": 12.9115931,
	  "tags": {
	    "ele": "2330",
	    "name": "Großer Schneiber",
	    "natural": "peak",
	    "ref:avf": "3420",
	    "wikidata": "Q18289350"
	  }
	},
	{
	  "type": "node",
	  "id": 506889874,
	  "lat": 47.4829148,
	  "lon": 12.9965197,
	  "tags": {
	    "alt_name": "Hochegger",
	    "ele": "2230",
	    "name": "Hocheck",
	    "natural": "peak",
	    "note": "Position aus Höhenlinienverlauf geschätzt"
	  }
	},
	{
	  "type": "node",
	  "id": 506889891,
	  "lat": 47.4969696,
	  "lon": 13.0377259,
	  "tags": {
	    "ele": "2236",
	    "name": "Wildpalfen",
	    "natural": "peak",
	    "ref:avf": "3010"
	  }
	},
	{
	  "type": "node",
	  "id": 507017748,
	  "lat": 47.5488385,
	  "lon": 13.0309162,
	  "tags": {
	    "ele": "2164",
	    "name": "Fagstein",
	    "natural": "peak",
	    "ref:avf": "2880",
	    "source": "estimated from height lines",
	    "wikidata": "Q21032716"
	  }
	},
	{
	  "type": "node",
	  "id": 507037980,
	  "lat": 47.5345871,
	  "lon": 13.0237221,
	  "tags": {
	    "ele": "2074",
	    "name": "Lafeldkopf",
	    "natural": "peak",
	    "note": "“Hohes Lafeld” oder “Hochlafeld” bezeichnet die Fläche unterhalb des Gipfels",
	    "ref:avf": "2950",
	    "source": "survey"
	  }
	},
	{
	  "type": "node",
	  "id": 507083764,
	  "lat": 47.5163295,
	  "lon": 12.9109261,
	  "tags": {
	    "ele": "2268",
	    "name": "Gjaidkopf",
	    "natural": "peak",
	    "ref:avf": "3430",
	    "wikidata": "Q30683386"
	  }
	},
	{
	  "type": "node",
	  "id": 507083769,
	  "lat": 47.5200228,
	  "lon": 12.9069035,
	  "tags": {
	    "ele": "2094",
	    "name": "Graskopf",
	    "natural": "peak",
	    "ref:avf": "3430",
	    "wikidata": "Q31354141"
	  }
	},
	{
	  "type": "node",
	  "id": 507094246,
	  "lat": 47.5596884,
	  "lon": 12.8549340,
	  "tags": {
	    "ele": "2468",
	    "name": "Steintalhörnl",
	    "natural": "peak",
	    "ref:avf": "2150",
	    "source": "estimated from height lines"
	  }
	},
	{
	  "type": "node",
	  "id": 507094248,
	  "lat": 47.5513535,
	  "lon": 12.8528061,
	  "tags": {
	    "ele": "2247",
	    "name": "Hinterbergkopf",
	    "natural": "peak",
	    "ref:avf": "2170",
	    "source": "estimated from height lines",
	    "wikidata": "Q31354042"
	  }
	},
	{
	  "type": "node",
	  "id": 507105613,
	  "lat": 47.5822000,
	  "lon": 12.8746816,
	  "tags": {
	    "ele": "2153",
	    "name": "Schärtenspitze",
	    "natural": "peak",
	    "ref:avf": "2020",
	    "source": "survey",
	    "summit:cross": "yes",
	    "summit:register": "yes",
	    "wikipedia": "de:Hochkalter#Schärtenspitze"
	  }
	},
	{
	  "type": "node",
	  "id": 507105618,
	  "lat": 47.5588894,
	  "lon": 12.9424556,
	  "tags": {
	    "alt_name": "Watzmannfrau;Watzfrau",
	    "ele": "2307",
	    "name": "Kleiner Watzmann",
	    "natural": "peak",
	    "ref:avf": "2440",
	    "source": "estimation from height lines",
	    "wikidata": "Q31339405"
	  }
	},
	{
	  "type": "node",
	  "id": 507116898,
	  "lat": 47.5436716,
	  "lon": 12.9036638,
	  "tags": {
	    "ele": "2257",
	    "name": "Griesspitze",
	    "natural": "peak",
	    "ref:avf": "2560",
	    "wikidata": "Q31354130"
	  }
	},
	{
	  "type": "node",
	  "id": 507448708,
	  "lat": 47.5308097,
	  "lon": 12.9341041,
	  "tags": {
	    "ele": "2066",
	    "name": "Hachelkopf",
	    "natural": "peak",
	    "ref:avf": "2580",
	    "source": "estimated from height lines"
	  }
	},
	{
	  "type": "node",
	  "id": 507594558,
	  "lat": 47.4764177,
	  "lon": 13.0185196,
	  "tags": {
	    "alt_name": "Lawand",
	    "ele": "2312",
	    "name": "Laubwand",
	    "natural": "peak",
	    "ref:avf": "3900",
	    "wikidata": "Q1680817",
	    "wikipedia": "de:Laubwand"
	  }
	},
	{
	  "type": "node",
	  "id": 508474971,
	  "lat": 47.4462043,
	  "lon": 11.0232944,
	  "tags": {
	    "ele": "2276",
	    "name": "Großer Waxenstein",
	    "natural": "peak",
	    "wikidata": "Q256209"
	  }
	},
	{
	  "type": "node",
	  "id": 508474978,
	  "lat": 47.4466790,
	  "lon": 11.0301167,
	  "tags": {
	    "ele": "2136",
	    "name": "Kleiner Waxenstein",
	    "natural": "peak"
	  }
	},
	{
	  "type": "node",
	  "id": 508474984,
	  "lat": 47.4439368,
	  "lon": 11.0174743,
	  "tags": {
	    "ele": "2268",
	    "name": "Hinterer Waxenstein",
	    "natural": "peak"
	  }
	},
	{
	  "type": "node",
	  "id": 508489594,
	  "lat": 47.4388036,
	  "lon": 11.0057910,
	  "tags": {
	    "ele": "2242",
	    "name": "Nördliche Riffelspitze",
	    "natural": "peak",
	    "wikidata": "Q31555745"
	  }
	},
	{
	  "type": "node",
	  "id": 508489606,
	  "lat": 47.4372180,
	  "lon": 11.0037847,
	  "tags": {
	    "ele": "2262",
	    "name": "Südliche Riffelspitze",
	    "natural": "peak"
	  }
	},
	{
	  "type": "node",
	  "id": 508489623,
	  "lat": 47.4281857,
	  "lon": 10.9927492,
	  "tags": {
	    "ele": "2625",
	    "name": "Große Riffelwandspitze",
	    "natural": "peak",
	    "wikidata": "Q31555666"
	  }
	},
	{
	  "type": "node",
	  "id": 508489627,
	  "lat": 47.4290020,
	  "lon": 10.9962523,
	  "tags": {
	    "ele": "2543",
	    "name": "Kleine Riffelwandspitze",
	    "natural": "peak",
	    "wikidata": "Q31555682"
	  }
	},
	{
	  "type": "node",
	  "id": 508489631,
	  "lat": 47.4346771,
	  "lon": 10.9982920,
	  "tags": {
	    "alt_name": "Hohe Riffel",
	    "ele": "2230",
	    "name": "Riffeltorkopf",
	    "natural": "peak",
	    "wikidata": "Q2152634",
	    "wikipedia": "de:Riffeltorkopf"
	  }
	},
	{
	  "type": "node",
	  "id": 508503689,
	  "lat": 47.4206907,
	  "lon": 11.0198273,
	  "tags": {
	    "ele": "2740",
	    "name": "Mittlere Höllentalspitze",
	    "natural": "peak"
	  }
	},
	{
	  "type": "node",
	  "id": 508503691,
	  "lat": 47.4184937,
	  "lon": 11.0105717,
	  "tags": {
	    "ele": "2741",
	    "name": "Innere Höllentalspitze",
	    "natural": "peak",
	    "wikidata": "Q265375"
	  }
	},
	{
	  "type": "node",
	  "id": 508503692,
	  "lat": 47.4108271,
	  "lon": 11.0167920,
	  "tags": {
	    "ele": "2260",
	    "name": "Brunntalkopf",
	    "natural": "peak",
	    "wikidata": "Q31550882"
	  }
	},
	{
	  "type": "node",
	  "id": 508503693,
	  "lat": 47.4209398,
	  "lon": 11.0278930,
	  "tags": {
	    "ele": "2715",
	    "name": "Äußere Höllentalspitze",
	    "natural": "peak"
	  }
	},
	{
	  "type": "node",
	  "id": 508503694,
	  "lat": 47.4217228,
	  "lon": 11.0346960,
	  "tags": {
	    "ele": "2630",
	    "name": "Vollkarspitze",
	    "natural": "peak",
	    "wikidata": "Q885103"
	  }
	},
	{
	  "type": "node",
	  "id": 508509265,
	  "lat": 47.4219531,
	  "lon": 11.0545854,
	  "tags": {
	    "ele": "2420",
	    "name": "Blassenspitze",
	    "natural": "peak"
	  }
	},
	{
	  "type": "node",
	  "id": 508530564,
	  "lat": 47.3964573,
	  "lon": 10.9926825,
	  "tags": {
	    "ele": "2680",
	    "name": "Östliche Plattspitze",
	    "natural": "peak",
	    "wikidata": "Q830583",
	    "wikipedia": "de:Plattspitzen"
	  }
	},
	{
	  "type": "node",
	  "id": 509292145,
	  "lat": 47.4885095,
	  "lon": 12.9749907,
	  "tags": {
	    "ele": "2460",
	    "name": "Hochscheibe",
	    "natural": "peak",
	    "wikidata": "Q31354346"
	  }
	},
	{
	  "type": "node",
	  "id": 509292149,
	  "lat": 47.4933161,
	  "lon": 12.9752088,
	  "tags": {
	    "ele": "2371",
	    "name": "Ebenhorn",
	    "natural": "peak",
	    "ref:avf": "3340",
	    "source": "Skelettskizze Funtenseetauern ca. 1920",
	    "wikidata": "Q30791818"
	  }
	},
	{
	  "type": "node",
	  "id": 510121135,
	  "lat": 47.5988564,
	  "lon": 12.7917253,
	  "tags": {
	    "ele": "2251",
	    "name": "Wagendrischelhorn",
	    "natural": "peak",
	    "wikidata": "Q829328"
	  }
	},
	{
	  "type": "node",
	  "id": 510121157,
	  "lat": 47.6023921,
	  "lon": 12.7970507,
	  "tags": {
	    "ele": "2106",
	    "name": "Unterer Plattelkopf",
	    "natural": "peak",
	    "wikidata": "Q21864853"
	  }
	},
	{
	  "type": "node",
	  "id": 510121159,
	  "lat": 47.6054624,
	  "lon": 12.8028361,
	  "tags": {
	    "ele": "2098",
	    "name": "Oberer Plattelkopf",
	    "natural": "peak",
	    "wikidata": "Q93701942"
	  }
	},
	{
	  "type": "node",
	  "id": 510121160,
	  "lat": 47.6102587,
	  "lon": 12.8074181,
	  "tags": {
	    "ele": "2060",
	    "name": "Reiter Steinberg",
	    "natural": "peak"
	  }
	},
	{
	  "type": "node",
	  "id": 510121162,
	  "lat": 47.6120942,
	  "lon": 12.8245353,
	  "tags": {
	    "ele": "2031",
	    "name": "Hohes Gerstfeld",
	    "natural": "peak"
	  }
	},
	{
	  "type": "node",
	  "id": 510122408,
	  "lat": 47.4716921,
	  "lon": 13.0037510,
	  "tags": {
	    "ele": "2110",
	    "name": "Rosentalhörnl",
	    "natural": "peak",
	    "source": "survey",
	    "wikidata": "Q31353035"
	  }
	},
	{
	  "type": "node",
	  "id": 515678324,
	  "lat": 47.4831655,
	  "lon": 11.3362025,
	  "tags": {
	    "ele": "2071",
	    "name": "Feldernkopf",
	    "natural": "peak",
	    "wikidata": "Q31547165"
	  }
	},
	{
	  "type": "node",
	  "id": 527273299,
	  "lat": 47.4307842,
	  "lon": 11.3035822,
	  "tags": {
	    "ele": "2241",
	    "name": "Westliches Kirchl",
	    "natural": "peak",
	    "wikidata": "Q111286543",
	    "wikipedia": "de:Kirchl (Karwendel)"
	  }
	},
	{
	  "type": "node",
	  "id": 527273302,
	  "lat": 47.4369645,
	  "lon": 11.3011712,
	  "tags": {
	    "ele": "2130",
	    "name": "Kreuzwand",
	    "natural": "peak",
	    "source": "estimated from NASA elevation data",
	    "wikidata": "Q31555715"
	  }
	},
	{
	  "type": "node",
	  "id": 527273304,
	  "lat": 47.4379450,
	  "lon": 11.2936810,
	  "tags": {
	    "ele": "2054",
	    "name": "Viererspitze",
	    "natural": "peak",
	    "wikidata": "Q15061381"
	  }
	},
	{
	  "type": "node",
	  "id": 527273309,
	  "lat": 47.4302026,
	  "lon": 11.3075093,
	  "tags": {
	    "ele": "2211",
	    "name": "Mittleres Kirchl",
	    "natural": "peak",
	    "wikidata": "Q111286543",
	    "wikipedia": "de:Kirchl (Karwendel)"
	  }
	},
	{
	  "type": "node",
	  "id": 527273311,
	  "lat": 47.4303184,
	  "lon": 11.3097695,
	  "tags": {
	    "ele": "2225",
	    "name": "Östliches Kirchl",
	    "natural": "peak"
	  }
	},
	{
	  "type": "node",
	  "id": 527343335,
	  "lat": 47.4304267,
	  "lon": 11.3113814,
	  "tags": {
	    "ele": "2303",
	    "name": "Westliche Larchetfleckspitze",
	    "natural": "peak"
	  }
	},
	{
	  "type": "node",
	  "id": 527343336,
	  "lat": 47.4307958,
	  "lon": 11.3134407,
	  "tags": {
	    "ele": "2362",
	    "name": "Östliche Larchetfleckspitze",
	    "natural": "peak",
	    "note": "m ü. A."
	  }
	},
	{
	  "type": "node",
	  "id": 527360269,
	  "lat": 47.4468728,
	  "lon": 11.3903390,
	  "tags": {
	    "ele": "2323",
	    "name": "Bäralplkopf",
	    "natural": "peak",
	    "wikidata": "Q21927860"
	  }
	},
	{
	  "type": "node",
	  "id": 527360288,
	  "lat": 47.4546499,
	  "lon": 11.4131303,
	  "tags": {
	    "ele": "2015",
	    "name": "Östliche Steinkarspitze",
	    "natural": "peak",
	    "source": "estimated from NASA elevation data",
	    "wikidata": "Q21873241",
	    "wikipedia": "de:Steinkarspitze (Karwendel)"
	  }
	},
	{
	  "type": "node",
	  "id": 664510186,
	  "lat": 47.5450497,
	  "lon": 12.8327097,
	  "tags": {
	    "ele": "2483",
	    "man_made": "summit_cross",
	    "name": "Kammerlinghorn",
	    "natural": "peak",
	    "ref:avf": "2260",
	    "source": "estimated from height lines",
	    "wikidata": "Q21868263",
	    "wikipedia": "de:Hochkalter#Kammerlinghorn"
	  }
	},
	{
	  "type": "node",
	  "id": 773900448,
	  "lat": 47.4421375,
	  "lon": 11.0116460,
	  "tags": {
	    "ele": "2264",
	    "name": "Schönangerspitze",
	    "natural": "peak",
	    "wikidata": "Q31522130"
	  }
	},
	{
	  "type": "node",
	  "id": 944092774,
	  "lat": 47.4126395,
	  "lon": 11.1301239,
	  "tags": {
	    "ele": "2427",
	    "name": "Westliche Törlspitze",
	    "natural": "peak",
	    "summit:cross": "no",
	    "summit:register": "no"
	  }
	},
	{
	  "type": "node",
	  "id": 1055352004,
	  "lat": 47.5720037,
	  "lon": 12.8694054,
	  "tags": {
	    "ele": "2481",
	    "name": "Blaueisspitze",
	    "natural": "peak",
	    "source": "estimated from height lines",
	    "summit:cross": "yes",
	    "wikidata": "Q31354412"
	  }
	},
	{
	  "type": "node",
	  "id": 1055352011,
	  "lat": 47.5857340,
	  "lon": 12.8776064,
	  "tags": {
	    "ele": "2065",
	    "name": "Steinberg",
	    "natural": "peak",
	    "ref:avf": "2010",
	    "summit:cross": "yes"
	  }
	},
	{
	  "type": "node",
	  "id": 1055547059,
	  "lat": 47.5727411,
	  "lon": 12.8624286,
	  "tags": {
	    "ele": "2513",
	    "name": "Kleinkalter",
	    "natural": "peak",
	    "ref:avf": "2060",
	    "source": "estimation from height lines",
	    "summit:cross": "no"
	  }
	},
	{
	  "type": "node",
	  "id": 1055547069,
	  "lat": 47.5461712,
	  "lon": 12.8478690,
	  "tags": {
	    "ele": "2368",
	    "name": "Wimbachschneidspitze",
	    "natural": "peak",
	    "ref:avf": "2180",
	    "source": "estimated from height lines"
	  }
	},
	{
	  "type": "node",
	  "id": 1055547071,
	  "lat": 47.5625765,
	  "lon": 12.8614196,
	  "tags": {
	    "ele": "2513",
	    "name": "Ofentalhörnl",
	    "natural": "peak",
	    "ref:avf": "2130",
	    "source": "estimated from height lines",
	    "wikidata": "Q31296619"
	  }
	},
	{
	  "type": "node",
	  "id": 1055547086,
	  "lat": 47.5841081,
	  "lon": 12.8613061,
	  "tags": {
	    "ele": "2065",
	    "name": "Schärtenwandkopf",
	    "natural": "peak",
	    "ref:avf": "2080",
	    "source": "estimated from height lines",
	    "summit:cross": "no"
	  }
	},
	{
	  "type": "node",
	  "id": 1055547112,
	  "lat": 47.5642609,
	  "lon": 12.8677725,
	  "tags": {
	    "ele": "2450",
	    "name": "Schönwandeck",
	    "natural": "peak",
	    "ref:avf": "2120",
	    "source": "estimated from height lines"
	  }
	},
	{
	  "type": "node",
	  "id": 1055547114,
	  "lat": 47.5786336,
	  "lon": 12.8621648,
	  "tags": {
	    "ele": "2367",
	    "name": "Rotpalfen",
	    "natural": "peak",
	    "ref:avf": "2070",
	    "source": "estimation from height lines",
	    "summit:cross": "no",
	    "wikidata": "Q1117892"
	  }
	},
	{
	  "type": "node",
	  "id": 1055583497,
	  "lat": 47.5546387,
	  "lon": 12.8316752,
	  "tags": {
	    "ele": "2252",
	    "name": "Hocheishörnl",
	    "natural": "peak",
	    "ref:avf": "2220",
	    "source": "estimated from height lines",
	    "wikidata": "Q31353994"
	  }
	},
	{
	  "type": "node",
	  "id": 1055583501,
	  "lat": 47.5583201,
	  "lon": 12.8357131,
	  "tags": {
	    "ele": "2095",
	    "name": "Eislhörnl",
	    "natural": "peak",
	    "ref:avf": "2200",
	    "source": "estimated from height lines"
	  }
	},
	{
	  "type": "node",
	  "id": 1055583505,
	  "lat": 47.5588020,
	  "lon": 12.8284226,
	  "tags": {
	    "ele": "2083",
	    "name": "Vorderberghörnl",
	    "natural": "peak",
	    "ref:avf": "2210",
	    "source": "estimated from height lines"
	  }
	},
	{
	  "type": "node",
	  "id": 1055583508,
	  "lat": 47.5509169,
	  "lon": 12.8391498,
	  "tags": {
	    "ele": "2493",
	    "name": "Hinterberghorn",
	    "natural": "peak",
	    "ref": "avf:2240",
	    "ref:avf": "2230",
	    "source": "estimated from height lines"
	  }
	},
	{
	  "type": "node",
	  "id": 1055599840,
	  "lat": 47.5323307,
	  "lon": 12.8706562,
	  "tags": {
	    "alt_name": "Kleines Palfelhorn",
	    "ele": "2073",
	    "name": "Kleines Palfenhorn",
	    "natural": "peak",
	    "ref:avf": "2330",
	    "source": "estimated from height lines",
	    "source:alt_name": "Königreich Bayern 1848;Franzisco-Josephinische Landesaufnahme;Max Zeller 1915",
	    "wikidata": "Q19964160",
	    "wikipedia": "de:Kleines Palfenhorn"
	  }
	},
	{
	  "type": "node",
	  "id": 1059463596,
	  "lat": 47.5537381,
	  "lon": 12.9378171,
	  "tags": {
	    "alt_name": "Erstes Watzmannkind",
	    "ele": "2247",
	    "name": "1. Watzmannkind",
	    "natural": "peak",
	    "ref:avf": "2460",
	    "source": "estimation from height lines"
	  }
	},
	{
	  "type": "node",
	  "id": 1059463616,
	  "lat": 47.5519243,
	  "lon": 12.9339669,
	  "tags": {
	    "alt_name": "Drittes Watzmannkind",
	    "ele": "2209",
	    "name": "3. Watzmannkind",
	    "natural": "peak",
	    "ref:avf": "2480",
	    "source:ele": "gps"
	  }
	},
	{
	  "type": "node",
	  "id": 1059463627,
	  "lat": 47.5527479,
	  "lon": 12.9328971,
	  "tags": {
	    "alt_name": "Viertes Watzmannkind",
	    "ele": "2270",
	    "name": "4. Watzmannkind",
	    "natural": "peak",
	    "ref:avf": "2490",
	    "source": "estimation from height lines"
	  }
	},
	{
	  "type": "node",
	  "id": 1059463633,
	  "lat": 47.5526978,
	  "lon": 12.9309994,
	  "tags": {
	    "alt_name": "Fünftes Watzmannkind",
	    "ele": "2225",
	    "name": "5. Watzmannkind",
	    "natural": "peak"
	  }
	},
	{
	  "type": "node",
	  "id": 1060100549,
	  "lat": 47.5146630,
	  "lon": 13.0275981,
	  "tags": {
	    "ele": "2073",
	    "name": "Hochsäul",
	    "natural": "peak",
	    "ref:avf": "2980",
	    "wikidata": "Q31353952"
	  }
	},
	{
	  "type": "node",
	  "id": 1060100551,
	  "lat": 47.5502715,
	  "lon": 13.0446421,
	  "tags": {
	    "ele": "2211",
	    "name": "Windschartenkopf",
	    "natural": "peak",
	    "ref:avf": "2900",
	    "wikidata": "Q93958735"
	  }
	},
	{
	  "type": "node",
	  "id": 1060286350,
	  "lat": 47.4812326,
	  "lon": 13.0243806,
	  "tags": {
	    "alt_name": "Schottmal",
	    "ele": "2139",
	    "name": "Schloßkopf",
	    "natural": "peak",
	    "ref:avf": "3900",
	    "wikidata": "Q21873251"
	  }
	},
	{
	  "type": "node",
	  "id": 1161136429,
	  "lat": 47.5445909,
	  "lon": 11.1992896,
	  "tags": {
	    "ele": "2008",
	    "name": "Krottenkopf Ostgipfel",
	    "natural": "peak",
	    "source_ref": "http://www.flickr.com/photos/kogo59/5454886506/"
	  }
	},
	{
	  "type": "node",
	  "id": 1391464505,
	  "lat": 47.5051969,
	  "lon": 13.0412450,
	  "tags": {
	    "alt_name": "Kragenköpfl",
	    "ele": "2147",
	    "name": "Bramasofenkopf",
	    "natural": "peak",
	    "note": "estimated from SRTM"
	  }
	},
	{
	  "type": "node",
	  "id": 1617914845,
	  "lat": 47.4475351,
	  "lon": 11.3987822,
	  "tags": {
	    "ele": "2356",
	    "name": "Vordere Schlichtenkarspitze",
	    "natural": "peak",
	    "wikidata": "Q21873245"
	  }
	},
	{
	  "type": "node",
	  "id": 1621410586,
	  "lat": 47.4254602,
	  "lon": 11.2909070,
	  "tags": {
	    "ele": "2239",
	    "inscription": "Mittlerelinderspitze 2300",
	    "name": "Mittlere Linderspitze",
	    "natural": "peak",
	    "wikidata": "Q15849891",
	    "wikipedia": "de:Linderspitzen"
	  }
	},
	{
	  "type": "node",
	  "id": 1621410656,
	  "lat": 47.4270819,
	  "lon": 11.2870608,
	  "tags": {
	    "ele": "2303",
	    "name": "Gerberkreuz",
	    "natural": "peak",
	    "wikidata": "Q31555001"
	  }
	},
	{
	  "type": "node",
	  "id": 1621410767,
	  "lat": 47.5090130,
	  "lon": 11.4876000,
	  "tags": {
	    "ele": "2102",
	    "name": "Schafreuter",
	    "natural": "peak",
	    "source": "aerial imagery;basemap.at",
	    "wikidata": "Q315887",
	    "wikipedia": "de:Schafreuter"
	  }
	},
	{
	  "type": "node",
	  "id": 1621651564,
	  "lat": 47.4464989,
	  "lon": 11.0261100,
	  "tags": {
	    "ele": "2226",
	    "name": "Zwölferkopf",
	    "natural": "peak",
	    "source": "kompass.de",
	    "wikidata": "Q31555875"
	  }
	},
	{
	  "type": "node",
	  "id": 1676377698,
	  "lat": 47.4186732,
	  "lon": 11.2926087,
	  "tags": {
	    "ele": "2321",
	    "inscription": "Sulzleklammspitze 2323m",
	    "name": "Sulzleklammspitze",
	    "natural": "peak",
	    "wikidata": "Q31517989"
	  }
	},
	{
	  "type": "node",
	  "id": 1833449059,
	  "lat": 47.4249269,
	  "lon": 11.0067851,
	  "tags": {
	    "ele": "2272",
	    "fixme": "elevation from internet (http://de.geoview.info/bergl,6939756)",
	    "name": "Bergl",
	    "natural": "peak",
	    "wikidata": "Q31555547"
	  }
	},
	{
	  "type": "node",
	  "id": 1833449069,
	  "lat": 47.4165238,
	  "lon": 11.0306086,
	  "tags": {
	    "ele": "2514",
	    "name": "Großer Kirchturm",
	    "natural": "peak",
	    "wikidata": "Q31544024"
	  }
	},
	{
	  "type": "node",
	  "id": 1833449075,
	  "lat": 47.4223964,
	  "lon": 11.0444402,
	  "tags": {
	    "ele": "2706",
	    "name": "Hochblassen",
	    "natural": "peak",
	    "wikidata": "Q870721"
	  }
	},
	{
	  "type": "node",
	  "id": 1833449085,
	  "lat": 47.4223324,
	  "lon": 11.0633797,
	  "tags": {
	    "ele": "2288",
	    "name": "Hoher Gaif",
	    "natural": "peak",
	    "summit:cross": "yes",
	    "wikidata": "Q31539054"
	  }
	},
	{
	  "type": "node",
	  "id": 1999392342,
	  "lat": 47.4066196,
	  "lon": 11.2882158,
	  "tags": {
	    "ele": "2192",
	    "name": "Rotwandlspitze",
	    "natural": "peak",
	    "summit:cross": "no",
	    "summit:register": "no",
	    "wikidata": "Q15273395",
	    "wikipedia": "de:Rotwandlspitze"
	  }
	},
	{
	  "type": "node",
	  "id": 2061799676,
	  "lat": 47.3959556,
	  "lon": 11.0553604,
	  "tags": {
	    "ele": "2744",
	    "name": "Hochwanner",
	    "natural": "peak",
	    "prominence": "699",
	    "wikidata": "Q255743",
	    "wikimedia_commons": "Category:Hochwanner",
	    "wikipedia": "de:Hochwanner"
	  }
	},
	{
	  "type": "node",
	  "id": 2076476475,
	  "lat": 47.4920061,
	  "lon": 11.3610059,
	  "tags": {
	    "ele": "2010",
	    "name": "Gumpenkarspitze",
	    "natural": "peak",
	    "source_ref": "http://www.flickr.com/photos/kogo59/8290882081/",
	    "summit:cross": "yes",
	    "wikidata": "Q15111956"
	  }
	},
	{
	  "type": "node",
	  "id": 2418167369,
	  "lat": 47.4816121,
	  "lon": 11.3424194,
	  "tags": {
	    "ele": "2174",
	    "ele:NN": "2174",
	    "name": "Soiernschneid",
	    "natural": "peak",
	    "wikidata": "Q31556117"
	  }
	},
	{
	  "type": "node",
	  "id": 2419126850,
	  "lat": 47.4935477,
	  "lon": 11.3690903,
	  "tags": {
	    "ele": "2110",
	    "name": "Krapfenkarspitze",
	    "natural": "peak",
	    "source_ref": "http://www.flickr.com/photos/kogo59/5413924577/",
	    "summit:cross": "yes",
	    "summit:register": "yes",
	    "wikidata": "Q15057166"
	  }
	},
	{
	  "type": "node",
	  "id": 2428070343,
	  "lat": 47.5905800,
	  "lon": 12.7978323,
	  "tags": {
	    "ele": "2234",
	    "fixme": "Lage",
	    "name": "Großes Mühlsturzhorn",
	    "natural": "peak",
	    "wikidata": "Q17250350"
	  }
	},
	{
	  "type": "node",
	  "id": 2428070344,
	  "lat": 47.5913873,
	  "lon": 12.8015976,
	  "tags": {
	    "ele": "2141",
	    "fixme": "Lage",
	    "name": "Kleines Mühlsturzhorn",
	    "natural": "peak",
	    "wikidata": "Q21693450"
	  }
	},
	{
	  "type": "node",
	  "id": 2428071182,
	  "lat": 47.5952828,
	  "lon": 12.8098121,
	  "tags": {
	    "ele": "2015",
	    "fixme": "Lage",
	    "name": "Knittelhorn",
	    "natural": "peak",
	    "source": "geoimage.at"
	  }
	},
	{
	  "type": "node",
	  "id": 2428071183,
	  "lat": 47.5925701,
	  "lon": 12.8060459,
	  "tags": {
	    "ele": "2096",
	    "fixme": "Lage",
	    "name": "Großes Grundübelhorn",
	    "natural": "peak"
	  }
	},
	{
	  "type": "node",
	  "id": 2428276691,
	  "lat": 47.5937287,
	  "lon": 12.8082407,
	  "tags": {
	    "ele": "2084",
	    "fixme": "Lage",
	    "name": "Kleines Grundübelhorn",
	    "natural": "peak"
	  }
	},
	{
	  "type": "node",
	  "id": 2441923393,
	  "lat": 47.4381568,
	  "lon": 11.0473410,
	  "tags": {
	    "ele": "2150",
	    "name": "Höllentorkopf",
	    "natural": "peak",
	    "wikidata": "Q1273885"
	  }
	},
	{
	  "type": "node",
	  "id": 2445853408,
	  "lat": 47.4296387,
	  "lon": 11.0001040,
	  "tags": {
	    "ele": "2389",
	    "name": "Riffelköpfe",
	    "natural": "peak"
	  }
	},
	{
	  "type": "node",
	  "id": 2489067962,
	  "lat": 47.4868317,
	  "lon": 13.0315637,
	  "tags": {
	    "ele": "2283",
	    "name": "Kleines Teufelshorn",
	    "natural": "peak",
	    "ref:avf": "3040",
	    "wikidata": "Q21873203"
	  }
	},
	{
	  "type": "node",
	  "id": 2496261339,
	  "lat": 47.5205032,
	  "lon": 13.0460473,
	  "tags": {
	    "ele": "2173",
	    "name": "Vorderer Kragenkopf",
	    "natural": "peak",
	    "source": "estimated from elevation lines"
	  }
	},
	{
	  "type": "node",
	  "id": 2496261392,
	  "lat": 47.5468447,
	  "lon": 12.8426400,
	  "tags": {
	    "ele": "2523",
	    "name": "Hocheisspitze",
	    "natural": "peak",
	    "ref:avf": "2240",
	    "wikidata": "Q871271",
	    "wikipedia": "de:Hocheisspitze"
	  }
	},
	{
	  "type": "node",
	  "id": 2498250593,
	  "lat": 47.4850145,
	  "lon": 12.9767787,
	  "tags": {
	    "ele": "2578.4",
	    "name": "Funtenseetauern",
	    "natural": "peak",
	    "ref:avf": "3350",
	    "wikidata": "Q316715",
	    "wikipedia": "de:Funtenseetauern"
	  }
	},
	{
	  "type": "node",
	  "id": 2498250705,
	  "lat": 47.4891572,
	  "lon": 13.0362619,
	  "tags": {
	    "ele": "2362",
	    "name": "Großes Teufelshorn",
	    "natural": "peak",
	    "ref:avf": "3030",
	    "wikidata": "Q320734"
	  }
	},
	{
	  "type": "node",
	  "id": 2506368453,
	  "lat": 47.3957891,
	  "lon": 11.1118219,
	  "tags": {
	    "ele": "2461",
	    "name": "Scharnitzspitze",
	    "natural": "peak",
	    "source": "survey",
	    "wikidata": "Q21865424",
	    "wikipedia": "de:Scharnitzspitze"
	  }
	},
	{
	  "type": "node",
	  "id": 2526645267,
	  "lat": 47.5483400,
	  "lon": 11.1798299,
	  "tags": {
	    "ele": "2046",
	    "name": "Kareck",
	    "natural": "peak",
	    "wikidata": "Q31536162"
	  }
	},
	{
	  "type": "node",
	  "id": 2875158437,
	  "lat": 47.5089561,
	  "lon": 12.9205349,
	  "tags": {
	    "ele": "2031",
	    "name": "Gamskarköpfl",
	    "natural": "peak"
	  }
	},
	{
	  "type": "node",
	  "id": 2934579315,
	  "lat": 47.5625765,
	  "lon": 12.8614196,
	  "tags": {
	    "ele": "2513",
	    "name": "Ofentalhörndl",
	    "natural": "peak",
	    "wikipedia": "de:Hochkalter#Ofentalhörnl"
	  }
	},
	{
	  "type": "node",
	  "id": 2980105509,
	  "lat": 47.5460878,
	  "lon": 12.8221541,
	  "tags": {
	    "ele": "2195",
	    "name": "Karlkopf",
	    "natural": "peak"
	  }
	},
	{
	  "type": "node",
	  "id": 2989185125,
	  "lat": 47.5873106,
	  "lon": 12.8762366,
	  "tags": {
	    "ele": "2026",
	    "name": "Steinberg",
	    "natural": "peak"
	  }
	},
	{
	  "type": "node",
	  "id": 3112764094,
	  "lat": 47.4028245,
	  "lon": 11.1049520,
	  "tags": {
	    "ele": "2014",
	    "name": "Oberreintalturm",
	    "natural": "peak",
	    "source": "survey"
	  }
	},
	{
	  "type": "node",
	  "id": 3116985621,
	  "lat": 47.5531398,
	  "lon": 12.9353854,
	  "tags": {
	    "alt_name": "Zweites Watzmannkind",
	    "ele": "2232",
	    "fixme": "exakt position",
	    "name": "2. Watzmannkind",
	    "natural": "peak"
	  }
	},
	{
	  "type": "node",
	  "id": 3116985622,
	  "lat": 47.5542784,
	  "lon": 12.9433972,
	  "tags": {
	    "ele": "2015",
	    "ele:source": "gps",
	    "name": "Lablkopf",
	    "natural": "peak"
	  }
	},
	{
	  "type": "node",
	  "id": 3186071317,
	  "lat": 47.5939262,
	  "lon": 13.0671406,
	  "tags": {
	    "ele": "2522",
	    "man_made": "cross",
	    "name": "Hoher Göll",
	    "natural": "peak",
	    "prominence": "789",
	    "ref:avf": "2690",
	    "summit:cross": "yes",
	    "wikidata": "Q549503",
	    "wikimedia_commons": "File:Hoher Göll - Gipfelkreuz.jpg"
	  }
	},
	{
	  "type": "node",
	  "id": 3237548037,
	  "lat": 47.5931666,
	  "lon": 12.7953337,
	  "tags": {
	    "ele": "2286",
	    "name": "Stadelhorn",
	    "natural": "peak",
	    "prominence": "1121",
	    "wikidata": "Q472226"
	  }
	},
	{
	  "type": "node",
	  "id": 3403866805,
	  "lat": 47.4857450,
	  "lon": 12.9610979,
	  "tags": {
	    "ele": "2050",
	    "name": "Ledererkopf",
	    "natural": "peak",
	    "source": "Skelettskizze Funtenseetauern ca. 1920"
	  }
	},
	{
	  "type": "node",
	  "id": 3634965710,
	  "lat": 47.4081217,
	  "lon": 11.1239416,
	  "tags": {
	    "ele": "2622",
	    "name": "Partenkirchner Dreitorspitze, Mittelgipfel",
	    "natural": "peak",
	    "summit:cross": "no"
	  }
	},
	{
	  "type": "node",
	  "id": 3634965711,
	  "lat": 47.4091248,
	  "lon": 11.1256736,
	  "tags": {
	    "ele": "2626",
	    "name": "Partenkirchner Dreitorspitze, Nordostgipfel",
	    "natural": "peak",
	    "summit:cross": "yes"
	  }
	},
	{
	  "type": "node",
	  "id": 3634965712,
	  "lat": 47.4127386,
	  "lon": 11.1353612,
	  "tags": {
	    "ele": "2444",
	    "name": "Östliche Törlspitze",
	    "natural": "peak",
	    "summit:cross": "no"
	  }
	},
	{
	  "type": "node",
	  "id": 3727777415,
	  "lat": 47.5964050,
	  "lon": 13.0527859,
	  "tags": {
	    "ele": "2047",
	    "name": "Pflughörndl",
	    "natural": "peak"
	  }
	},
	{
	  "type": "node",
	  "id": 3777140321,
	  "lat": 47.4150815,
	  "lon": 11.1280779,
	  "tags": {
	    "ele": "2369",
	    "name": "Frauenalplspitz",
	    "natural": "peak",
	    "summit:cross": "no",
	    "wikidata": "Q31555531"
	  }
	},
	{
	  "type": "node",
	  "id": 3777140322,
	  "lat": 47.4166877,
	  "lon": 11.1277051,
	  "tags": {
	    "ele": "2351.5",
	    "name": "Frauenalplkopf",
	    "natural": "peak",
	    "summit:cross": "yes",
	    "wikidata": "Q31555471"
	  }
	},
	{
	  "type": "node",
	  "id": 4059510444,
	  "lat": 47.4106410,
	  "lon": 11.1264927,
	  "tags": {
	    "alt_name": "Signalkopf",
	    "ele": "2486",
	    "fixme": "position estimated",
	    "name": "Signalkuppe",
	    "natural": "peak"
	  }
	},
	{
	  "type": "node",
	  "id": 4059510445,
	  "lat": 47.4099632,
	  "lon": 11.1265424,
	  "tags": {
	    "ele": "2507",
	    "fixme": "position estimated",
	    "name": "Bayerländerturm",
	    "natural": "peak"
	  }
	},
	{
	  "type": "node",
	  "id": 4256065941,
	  "lat": 47.5176763,
	  "lon": 13.0353451,
	  "tags": {
	    "ele": "2106.7",
	    "name": "Schossenkopf",
	    "natural": "peak",
	    "note": "Höhe: Hist. Karte ca.1900",
	    "wikidata": "Q31324123"
	  }
	},
	{
	  "type": "node",
	  "id": 4270248273,
	  "lat": 47.5173821,
	  "lon": 13.0289044,
	  "tags": {
	    "ele": "2054.5",
	    "name": "Grauer Kopf",
	    "natural": "peak"
	  }
	},
	{
	  "type": "node",
	  "id": 4687406836,
	  "lat": 47.5737113,
	  "lon": 12.8755931,
	  "tags": {
	    "ele": "2012",
	    "name": "Kopf des Hunds",
	    "natural": "peak"
	  }
	},
	{
	  "type": "node",
	  "id": 4689311473,
	  "lat": 47.5455209,
	  "lon": 12.8384593,
	  "tags": {
	    "ele": "2495",
	    "name": "Hocheiskopf",
	    "natural": "peak"
	  }
	},
	{
	  "type": "node",
	  "id": 4938279910,
	  "lat": 47.4143420,
	  "lon": 11.0308341,
	  "tags": {
	    "ele": "2368",
	    "name": "Kleiner Kirchturm",
	    "natural": "peak",
	    "wikidata": "Q31534553"
	  }
	},
	{
	  "type": "node",
	  "id": 4944025921,
	  "lat": 47.4017931,
	  "lon": 11.0724993,
	  "tags": {
	    "ele": "2355",
	    "name": "Jungfernkarkopf",
	    "natural": "peak"
	  }
	},
	{
	  "type": "node",
	  "id": 5034081693,
	  "lat": 47.4919950,
	  "lon": 11.3287726,
	  "tags": {
	    "ele": "2048",
	    "name": "Feldernkreuz",
	    "natural": "peak",
	    "wikidata": "Q15056103"
	  }
	},
	{
	  "type": "node",
	  "id": 5079866695,
	  "lat": 47.5843857,
	  "lon": 13.0496897,
	  "tags": {
	    "ele": "2340",
	    "name": "Hohes Brett",
	    "natural": "peak",
	    "note": "ele was 2331.8",
	    "ref:avf": "2720",
	    "summit:cross": "yes",
	    "wikidata": "Q1623963",
	    "wikipedia": "de:Hohes Brett"
	  }
	},
	{
	  "type": "node",
	  "id": 5817402896,
	  "lat": 47.4802879,
	  "lon": 11.3443547,
	  "tags": {
	    "ele": "2209",
	    "ele:NN": "2209",
	    "name": "Reißende Lahnspitz",
	    "natural": "peak",
	    "wikidata": "Q31526445"
	  }
	},
	{
	  "type": "node",
	  "id": 5926552247,
	  "lat": 47.4177816,
	  "lon": 11.1484033,
	  "tags": {
	    "ele": "2304",
	    "name": "Drei Scharten",
	    "natural": "peak"
	  }
	},
	{
	  "type": "node",
	  "id": 6530414814,
	  "lat": 47.4023869,
	  "lon": 11.0830808,
	  "tags": {
	    "ele": "2338",
	    "name": "Kleiner Hundsstallkopf",
	    "natural": "peak",
	    "wikidata": "Q31555357"
	  }
	},
	{
	  "type": "node",
	  "id": 6530414816,
	  "lat": 47.4172061,
	  "lon": 11.1403030,
	  "tags": {
	    "ele": "2276",
	    "name": "Hirschbichlkopf",
	    "natural": "peak",
	    "wikidata": "Q31555502"
	  }
	},
	{
	  "type": "node",
	  "id": 6530414818,
	  "lat": 47.4280299,
	  "lon": 11.1991612,
	  "tags": {
	    "ele": "2151",
	    "name": "Untere Wettersteinspitze",
	    "natural": "peak",
	    "wikidata": "Q2566053",
	    "wikipedia": "de:Wettersteinspitzen"
	  }
	},
	{
	  "type": "node",
	  "id": 6619156558,
	  "lat": 47.6049327,
	  "lon": 12.8099509,
	  "tags": {
	    "ele": "2004",
	    "name": "Predigtstuhl",
	    "natural": "peak"
	  }
	},
	{
	  "type": "node",
	  "id": 6690737689,
	  "lat": 47.4155275,
	  "lon": 11.2928413,
	  "tags": {
	    "alt_name": "Kirchlspitze",
	    "ele": "2301",
	    "name": "Kirchlespitze",
	    "natural": "peak",
	    "wikidata": "Q21879083"
	  }
	},
	{
	  "type": "node",
	  "id": 11926109175,
	  "lat": 47.3958358,
	  "lon": 11.0837236,
	  "tags": {
	    "ele": "2648",
	    "name": "Teufelsgrat",
	    "natural": "peak",
	    "wikidata": "Q9357673"
	  }
	},
	{
	  "type": "node",
	  "id": 12097971760,
	  "lat": 47.4060619,
	  "lon": 11.1151897,
	  "tags": {
	    "ele": "2371",
	    "name": "Oberreintaldom",
	    "natural": "peak"
	  }
	},
	{
	  "type": "node",
	  "id": 12097971761,
	  "lat": 47.4001811,
	  "lon": 11.1109756,
	  "tags": {
	    "ele": "2200",
	    "name": "Unterer Schüsselkarturm",
	    "natural": "peak"
	  }
	},
	{
	  "type": "node",
	  "id": 12468970499,
	  "lat": 47.4000170,
	  "lon": 11.0615952,
	  "tags": {
	    "ele": "2403",
	    "name": "Höhlenkopf",
	    "natural": "peak"
	  }
	}
	]
}
]'  -- end of JSON text
	, '$.elements[*]' 
	COLUMNS (
	    name 	VARCHAR2(100) 	PATH '$.tags.name'
	   ,ele 	NUMBER 			PATH '$.tags.ele'
	   ,osm_id 	NUMBER 			PATH '$.id'
	   ,lat 	NUMBER 			PATH '$.lat'
	   ,lon 	NUMBER 			PATH '$.lon'
	) 
) jt 
;
