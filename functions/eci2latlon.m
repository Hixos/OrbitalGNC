function [lat,lon] = eci2latlon(t_jd, r)
    theta_g = sidereal(t_jd);
    [alpha, delta] = eci2radec(r);
    alpha_angle = alpha./24*2*pi;
    
    lon = rad2deg(wrapToPi(alpha_angle - theta_g));
    lat = rad2deg(delta);
end

