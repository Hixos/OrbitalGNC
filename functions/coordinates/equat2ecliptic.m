function [y_ecl] = equat2ecliptic(y_eq)
%ECLIPTIC2EQUAT Converts coordinates from the J2000 ecliptic frame to the
%J2000 equatorial frame

eps = deg2rad(23.43928);

Q = [1, 0, 0; 0, cos(eps), -sin(eps); 0, sin(eps), cos(eps) ];
Q = Q';
y_ecl = zeros(size(y_eq));

for i=1:size(y_eq, 1)
    for j=1:3:size(y_eq,2)
        y_ecl(i,j:j+2) = (Q*y_eq(i,j:j+2)').';
    end
end

end

