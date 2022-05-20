G = 6.6743e-11;

bodies.earth.name = 'earth';

bodies.sun.M = 1.989e30;
bodies.sun.mu = bodies.sun.M*G*1e-9;

bodies.moon.R = 1737.4;
bodies.moon.mu = 4.9048695e12*1e-9;
bodies.moon.name = 'moon';

bodies.moon.orbit.a = deg2rad([6.29, -1.27, 0.66, 0.21, -0.19, -0.11]);
bodies.moon.orbit.b = deg2rad([218.32, 135.0, 259.3, 235.7, 269.9, 357.5, 206.6]);
bodies.moon.orbit.c = deg2rad([481267.881, 477198.87, -413335.36, 890534.22, 954397.74, 35999.05, 966404.03]);
bodies.moon.orbit.d = deg2rad([5.13, 0.28, -0.28, -0.17]);
bodies.moon.orbit.e = deg2rad([93.3, 220.2, 318.3, 217.6]);
bodies.moon.orbit.f = deg2rad([483202.03, 960400.89, 6003.15, -407332.21]);
bodies.moon.orbit.g = deg2rad([0.9508, 0.0518, 0.0095, 0.0078, 0.0028]);
bodies.moon.orbit.h = deg2rad([135.0, 259.3, 253.7, 269.9]);
bodies.moon.orbit.k = deg2rad([477198.87, -413335.38, 890534.22, 954397.70]);


AU = 1.49597871e8;

bodies.planets = {'mercury', 'venus', 'earth', 'mars', 'jupiter', 'saturn', 'uranus', 'neptune'};
ephemerides = readmatrix("data/planetary_ephemerides.txt");
sizes = readmatrix("data/planetary_sizes.txt");
for i=1:length(bodies.planets)
    r = i*2-1;
    eph = ephemerides(r:r+1,:);
    
    
    bodies.(bodies.planets{i}).name = bodies.planets{i};
    bodies.(bodies.planets{i}).ephem.a = eph(1,1)*AU;
    bodies.(bodies.planets{i}).ephem.a_d = eph(2,1)*AU;
    bodies.(bodies.planets{i}).ephem.e = eph(1,2);
    bodies.(bodies.planets{i}).ephem.e_d = eph(2,2);
    bodies.(bodies.planets{i}).ephem.i = deg2rad(eph(1,3));
    bodies.(bodies.planets{i}).ephem.i_d = deg2rad(eph(2,3));
    bodies.(bodies.planets{i}).ephem.L = deg2rad(eph(1,4));
    bodies.(bodies.planets{i}).ephem.L_d = deg2rad(eph(2,4));
    bodies.(bodies.planets{i}).ephem.om = deg2rad(eph(1,5));
    bodies.(bodies.planets{i}).ephem.om_d = deg2rad(eph(2,5));
    bodies.(bodies.planets{i}).ephem.Om = deg2rad(eph(1,6));
    bodies.(bodies.planets{i}).ephem.Om_d = deg2rad(eph(2,6));
    
    bodies.(bodies.planets{i}).M = sizes(1,i)*1e24;
    bodies.(bodies.planets{i}).R = sizes(2,i)/2;
    bodies.(bodies.planets{i}).mu = G*bodies.(bodies.planets{i}).M*1e-9;
end
