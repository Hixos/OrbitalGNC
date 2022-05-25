function [dy_dt] = eci_solar_system_ode(t, y, opt, bodies)
    r_sc = y(1:3);
   
    JD = opt.JD0 + t/3600/24;
    
    Nbodies = length(bodies.planets) + 1;
    
    mu_bodies = zeros(Nbodies,1);
    r_rel_bodies = zeros(Nbodies, 3);
        
    % Moon position
    mu_bodies(end) = bodies.moon.mu;
    r_rel_bodies(end,:) = r_sc' - moon_position(opt.J20 + sec2century(t), bodies.moon);
    
    
    r_e = ephem2sci(JD, bodies.earth.ephem, bodies.sun);
   
    % Planets position
    for i=1:Nbodies-1
        mu_bodies(i) = bodies.(bodies.planets{i}).mu;
        r_p = ephem2sci(JD, bodies.(bodies.planets{i}).ephem, bodies.sun);
        r_p_eci = ecliptic2equat(r_p-r_e);
        r_rel_bodies(i,:) = r_sc' - r_p_eci;
    end
    
    % Calculate gravitational accelerations
    A = zeros(3,1);   
    for i=1:Nbodies
       r_b = r_rel_bodies(i,:)';
       r_b_norm =  norm(r_b);
       
       
       A = A + -mu_bodies(i)/r_b_norm^3*r_b;
    end
         
    a = A + J2_acc(r_sc', bodies.earth)';
    dy_dt = zeros(6,1);
    dy_dt(1:3) = y(4:6);
    dy_dt(4:6) = a;   
end

