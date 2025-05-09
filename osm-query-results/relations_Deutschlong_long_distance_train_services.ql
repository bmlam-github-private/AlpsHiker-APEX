[out:json][timeout:60];

area ["name"="Deutschland"] -> .myArea;
(
  relation (area.myArea) [ "type"="route" ]  [ "route"="train" ] ["service"="long_distance"] ;
);

out tags;
