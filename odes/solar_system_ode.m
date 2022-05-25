function [dy_dt] = solar_system_ode(t, y, opt, bodies)
    r_sc = y(1:3);
   
    JD = opt.JD0 + t/3600/24;
    
    Nbodies = length(bodies.planets) + 1;
    
    mu_bodies = zeros(Nbodies,1);
    r_rel_bodies = zeros(Nbodies, 3);
    
    i_earth = find(strcmp(bodies.planets, 'earth'));
    
    % Moon position
    mu_bodies(end) = bodies.moon.mu;
    r_moon_ecl = eci2sci(moon_position(opt.J20 + sec2century(t), bodies.moon));
    r_rel_bodies(end,:) = r_sc' - r_moon_ecl;
    
    % Planets position
    for i=1:Nbodies-1
        mu_bodies(i) = bodies.(bodies.planets{i}).mu;
        r_p = ephem2sci(JD, bodies.(bodies.planets{i}).ephem, bodies.sun);
        r_rel_bodies(i,:) = r_sc' - r_p;
    end
    
    % Calculate gravitational accelerations
    A = zeros(3,1);   
    for i=1:Nbodies
       r_b = r_rel_bodies(i,:)';
       r_b_norm =  norm(r_b);
       
       
       A = A + -mu_bodies(i)/r_b_norm^3*r_b;
    end
         
    a = A;
    if norm(r_rel_bodies(i_earth, :)) < 321
        a = a + J2_acc(ecliptic2equat(r_rel_bodies(i_earth, :)), bodies.earth)';
    end
    dy_dt = zeros(6,1);
    dy_dt(1:3) = y(4:6);
    dy_dt(4:6) = a;   
end

