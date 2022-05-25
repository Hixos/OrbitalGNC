close all
clearvars
clc

initfolders
initdata

opt.JD0 = datetime2julian();
opt.theta0 = sidereal(opt.JD0);
opt.J20 = J2000(opt.JD0);


orb_1.e = 0.01;
orb_1.a = bodies.earth.R + 500;
orb_1.i = deg2rad(45);
orb_1.Om = deg2rad(0);
orb_1.om = deg2rad(0);
orb_1.th = deg2rad(0);
orb_1.epoch = opt.JD0;

orb_2.e = 0.01;
orb_2.a = bodies.earth.R + 5000;
orb_2.i = deg2rad(30);
orb_2.Om = deg2rad(0);
orb_2.om = deg2rad(0);
orb_2.th = deg2rad(0);
orb_2.epoch = opt.JD0;

T1 = period(orb_1, bodies.earth);
T2 = period(orb_2, bodies.earth);

JD0 = linspace(opt.JD0, opt.JD0 + T1/86400, 50);
DT = linspace(10*60, max(T1,T2), 50);
DVMAX = 10;
[DV, X, Y, V1T] = porkchop(orb_1, orb_2, JD0, DT, 50, bodies.earth);
DV(DV>DVMAX) = DVMAX;

figure
contourf(X,Y./60,DV,'--');


%% Orbit
[rmin, imin] = min(DV, [], 1);
[DV_min, jmin] = min(rmin);

imin = imin(jmin);

DV_opt = DV_min
V1T_opt = squeeze(V1T(imin, jmin, :))';
JD_T_start = X(imin, jmin);
JD_T_end = JD_T_start + Y(imin, jmin)/86400;

r1 = kep2car(propagate_elements(orb_1, JD_T_start, bodies.earth), bodies.earth);
orb_t = car2kep(JD_T_start, r1, V1T_opt, bodies.earth);


JDO1 = JD_T_start + linspace(-period(orb_1, bodies.earth)*0.9, 0, 1000)./86400;
JDO2 = JD_T_end + linspace(0, period(orb_2, bodies.earth), 1000)./86400;
JDT = linspace(JD_T_start, JD_T_end, 500);

orb_1_v = propagate_elements(orb_1, JDO1, bodies.earth);
orb_t_v = propagate_elements(orb_t, JDT, bodies.earth);
orb_2_v = propagate_elements(orb_2, JDO2, bodies.earth);

r1_v = kep2car(orb_1_v, bodies.earth);
rt_v = kep2car(orb_t_v, bodies.earth);
r2_v = kep2car(orb_2_v, bodies.earth);
%%
figure
plotorbit3(r1_v);
hold on
plotorbit3(rt_v);
plotorbit3(r2_v);