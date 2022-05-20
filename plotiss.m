% close all
clearvars

initfuncs
initdata

iss_tle_str = fileread("tles/iss.tle");
iss_tle = parseTLE(iss_tle_str)

el0 = tle2kepler(iss_tle, bodies.earth)
t0_jd = datetime2julian()-2/24;
t_jd = linspace(t0_jd, t0_jd+1.5/24, 1000).';

el = propagate_elements(el0, t_jd, bodies.earth);
y = kep2car(el, bodies.earth);

[lat, lon] = eci2latlon(t_jd, y(:,1:3));


% ll = [lat(1), lon(1)]

t = (t_jd - t_jd(1))*86400;
figure
plotelements(t, el);

figure
ground_track(lat, lon, [], 'Earth');