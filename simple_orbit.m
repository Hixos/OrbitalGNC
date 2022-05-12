close all
clearvars

initfuncs

N = 10000;
Tend = 2*60*60;
V0 = 8000;

data.G = 6.6743e-11;
data.M = 5.972e24;
data.mu = 3.986004418e14;

data.alpha0 = deg2rad(45);
data.delta0 = deg2rad(0);
data.R0 = 6371 + 500*1000;

data.tang_thrust = 0;

y0 = zeros(1,6);
y0(1:3) = radec2eci(data.alpha0, data.delta0, data.R0);

% uv = cross([0,0,1], y0(1:3));
uv = [2,1,1];
uv = uv./norm(uv);

y0(4:6) = uv*V0;

orbit_fun = @(t,y) simple_orbit_fun(t,y,data);
tspan = linspace(0, Tend, N);


opts =  odeset('RelTol',1e-6);

[t,y] = ode113(orbit_fun, tspan, y0, opts);

[alpha_vec, delta_vec, R] = eci2radec(y(:,1:3));

el = elements(y, data);


figure
plotorbit3(eci2perifocal(y, data));


figure
plotorbit2(y, data);


figure
plotelements(t, el);

