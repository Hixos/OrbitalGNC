function [dy_dt] = earth_orbit_ode(t, y, opt, bodies)
    r = y(1:3);
    R = norm(r);
    ur = r./R;
    
    rm = moon_position(opt.J20 + sec2century(t), bodies.moon)';
    rms = r - rm;
    
    Rms = norm(rms);
    urms = rms./Rms;
        
    Ae = -bodies.earth.mu/R^2;
    Am = -bodies.moon.mu/Rms^2;
    a = Ae*ur;
    a = a + Am*urms + J2_acc(r', bodies.earth)';
    dy_dt = zeros(6,1);
    dy_dt(1:3) = y(4:6);
    dy_dt(4:6) = a;   
end

