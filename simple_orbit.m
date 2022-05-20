close all
clearvars
clc

initfuncs
initdata

N = 5000; % Number of steps

% Norbit = 15*2; % Number of orbits
Tend = 2*60*60;

% kep0.e = 0.1;
% kep0.a = bodies.earth.R + 500;
% kep0.i = deg2rad(45);
% kep0.Om = deg2rad(0);
% kep0.om = deg2rad(0);
% kep0.th = deg2rad(0);
% kep0.epoch = opt.JD0;

opt.JD0 = datetime2julian();
opt.theta0 = sidereal(opt.JD0);
opt.J20 = J2000(opt.JD0);

kep0 = tlefile2kepler("data/iss2.tle", bodies.earth);
kep0 = propagate_elements(kep0, opt.JD0, bodies.earth);
% if kep0.e < 1
%     Torbit = 2*pi/sqrt(bodies.earth.mu)*kep0.a^(3/2);
%     Tend = Torbit*Norbit;
% else
%     Tend = 24*60*60;
% end
[r0, v0] = kep2car(kep0, bodies.earth);
y0 = [r0, v0];

orbit_fun = @(t,y) orbit_ode_fun(t, y, opt, bodies);
tspan = linspace(0, Tend, N);


opts =  odeset('RelTol', 1e-13);

[t,y] = ode113(orbit_fun, tspan, y0, opts);
t_jd = opt.JD0 + t./86400;
% y(1:3) = y(1:3)*1000;

[alpha_vec, delta_vec, R] = eci2radec(y(:,1:3));

el = car2kep(t_jd, y(:,1:3), y(:,4:6), bodies.earth);

t_J2 = opt.J20 + sec2century(t);
rmoon = moon_position(t_J2, bodies.moon);

[alpha_moon, delta_moon] = eci2radec(rmoon);
[alpha_sat, delta_sat] = eci2radec(y);

[lat_sat, lon_sat] = eci2latlon(t_jd, y(:,1:3));
[lat_moon, lon_moon] = eci2latlon(t_jd, rmoon);



figure
plotorbit3(y);
% hold on
% plotorbit3(rmoon);


% figure
% Q_pi = perifocalrot(y(1,:), bodies.earth);
% plotorbit2(y, Q_pi);
% hold on
% plotorbit2(rmoon, Q_pi);


figure
plotelements(t, el);

figure
tl = plotradec(t, alpha_sat, delta_sat, "Sat");
plotradec(t, alpha_moon, delta_moon, "Moon", tl);

figure
ground_track(lat_sat, lon_sat, [],'Earth');
