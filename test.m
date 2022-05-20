clc
clearvars
close all

initfuncs
initdata

opt.JD0 = 2459720.053565380;%datetime2julian(datetime(2050,01,01));

kep0 = tlefile2kepler("data/iss2.tle", bodies.earth);
kep0 = propagate_elements(kep0, opt.JD0, bodies.earth);
[r0, v0] = kep2car(kep0, bodies.earth);
y0 = [r0,v0];

r_earth = ephem2sci(opt.JD0, bodies.earth.ephem, bodies.sun)
r_earth_equat = ecliptic2equat(r_earth)

y_eci = y0

y_ecl = equat2ecliptic(y_eci)
y_eci_2 = ecliptic2equat(y_ecl)


y_sci = eci2sci(opt.JD0, y_eci, bodies)
y_eci_2 = sci2eci(opt.JD0, y_sci, bodies)
