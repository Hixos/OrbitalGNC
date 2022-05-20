function [r,v] = ephem2sci(epoch, ephem, sun)
% EPHEM2KEPLER(epoch, ephem) converts planetary ephemerides to cartesian
% coordinates expressed in the ecliptic J2000 frame centered in the sun
% See: https://ssd.jpl.nasa.gov/planets/approx_pos.html

    kep = ephem2kepler(epoch, ephem);
    [r,v] = kep2car(kep, sun);
end

