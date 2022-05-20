function rm = moon_position(T0, moon)
p = moon.orbit;

eps = deg2rad(23.439 - 0.0130042*T0);
long = p.b(1) + p.c(1)*T0;
lat = 0;
HP = p.g(1);
for i = 1:6
    long = long + p.a(i)*sin(p.b(i+1) + p.c(i+1)*T0); 
end

for i = 1:4
    lat = lat + p.d(i)*sin(p.e(i)+p.f(i)*T0);
end

for i = 1:4
    HP = HP + p.g(i+1)*cos(p.h(i)+p.k(i)*T0);
end
rm_norm = 6378./sin(HP);
rm = rm_norm.*[cos(lat).*cos(long), ...
              cos(eps).*cos(lat).*sin(long)-sin(eps).*sin(lat), ...
              sin(eps).*cos(lat).*sin(long)+cos(eps).*sin(lat)];
end