function [y_eq] = ecliptic2equat(y_ecl)
%ECLIPTIC2EQUAT Converts coordinates from the J2000 ecliptic frame to the
%J2000 equatorial frame

eps = deg2rad(23.439279);

Q = [1, 0, 0; 0, cos(eps), -sin(eps); 0, sin(eps), cos(eps) ];
y_eq = zeros(size(y_ecl));
for i=1:size(y_ecl, 1)
    for j=1:3:size(y_ecl,2)
        y_eq(i,j:j+2) = (Q*y_ecl(i,j:j+2)').';
    end
end
end

