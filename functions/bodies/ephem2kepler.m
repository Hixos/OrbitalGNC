function [kep] = ephem2kepler(epoch, ephem)
% EPHEM2KEPLER(epoch, ephem) converts planetary ephemerides to keplerian
% elements at the specified epoch
% See: https://ssd.jpl.nasa.gov/planets/approx_pos.html

    T = J2000(epoch);
    
    kep.epoch = epoch;
    
    ephem.om = ephem.om + ephem.om_d*T;
    ephem.Om = ephem.Om + ephem.Om_d*T;
    ephem.a = ephem.a + ephem.a_d*T;
    ephem.e = ephem.e + ephem.e_d*T;
    ephem.i = ephem.i + ephem.i_d*T;
    ephem.L = ephem.L + ephem.L_d*T;
    
    kep.a = ephem.a;
    kep.e = ephem.e;
    kep.i = ephem.i;
    kep.Om = ephem.Om;
    kep.om = ephem.om - ephem.Om;
 
    M = wrapTo2Pi(ephem.L - ephem.om);
    kep.th = mean2true_anomaly(kep.e, M);
end

