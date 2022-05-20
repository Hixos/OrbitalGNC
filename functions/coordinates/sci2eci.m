function [y_eci] = sci2eci(jd, y_sci, bodies)
%SCI2ECI Converts a state vector [r, v] from the sun centered ecliptic 
%frame to the earth centered equatiorial frame

[r_e, v_e] = ephem2sci(jd, bodies.earth.ephem, bodies.sun);

if size(y_sci,2) == 6
    y_e = [r_e, v_e];
else
    y_e = r_e;
end

y_eci = ecliptic2equat(y_sci-y_e);
end

