function [dy_dt] = simple_orbit_fun(t, y, data)
    r = y(1:3);
    R = norm(r);
    ur = r./R;
    
    v = y(4:6);
    uv = v./norm(v);
    
    A = -data.mu/R^2;
    a = A*ur;
    dy_dt = zeros(6,1);
    dy_dt(1:3) = y(4:6);
    dy_dt(4:6) = a + uv*data.tang_thrust;   
end

