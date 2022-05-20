function  groundtrack(lat, lon)
lat = rad2deg(lat);
lon = rad2deg(lon);

geoplot(lat, lon);
geolimits([-85,85],[-180 180])
geobasemap satellite
end

