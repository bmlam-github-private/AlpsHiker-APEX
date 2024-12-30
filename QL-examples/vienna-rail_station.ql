[out:json][timeout:600];
area[name="Wien"]->.a;

(
  node["railway"="station"](area.a);
  way["railway"="station"](area.a);
  relation["railway"="station"](area.a);
);

out body;
out tags;