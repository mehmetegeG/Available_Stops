function t = timespend(yourlon,yourlat,StopLon,StopLat)
speed=0.0613;
d=distance(yourlon,yourlat,StopLon,StopLat);
t=d./speed;
end
