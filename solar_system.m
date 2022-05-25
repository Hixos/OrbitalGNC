close all
clearvars
clc

initfolders
initdata

N = 500;
Nplanets = length(bodies.planets);

opt.JD0 = datetime2julian();

r = zeros(N, 3*Nplanets);

figure
for i=1:Nplanets
    kep = ephem2kepler(opt.JD0, bodies.(bodies.planets{i}).ephem);
    T = period(kep, bodies.sun);
    t_JD = linspace(opt.JD0, opt.JD0 + T/86400*0.9, N);
    
    kep_v = propagate_elements(kep, t_JD, bodies.sun);
    j = (i-1)*Nplanets+1;
    r(:, j:j+2) = kep2car(kep_v, bodies.sun);
end

r = r./1.496e8;
for i=1:Nplanets
    j = (i-1)*Nplanets+1;
    plotorbit3(r(:, j:j+2), false);
    hold on
end