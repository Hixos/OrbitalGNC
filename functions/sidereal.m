function [theta] = sidereal(jd, long)
if nargin < 3 
    long = 0;
end
T = J2000(jd);
theta = wrapTo2Pi(deg2rad(280.46061837 + 360.98564736629*(jd-2451545)+0.000387933*T.^2-T.^3./38710000 + long));
end

