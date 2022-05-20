function [y_sci] = eci2sci(jd, y_eci, bodies)
%SCI2ECI Converts a vector from the sun centered ecliptic frame to the
%earth centered equatiorial frame

[r_e, v_e] = ephem2sci(jd, bodies.earth.ephem, bodies.sun);

if size(y_eci,2) == 6
    y_e = [r_e, v_e];
else
    y_e = r_e;
end

y_sci = equat2ecliptic(y_eci) + y_e;

end

