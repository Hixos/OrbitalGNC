function [a] = J2_acc(r, earth)
r_norm = vecnorm(r,2,2);

J2 = 0.00108263;
a = -3/2*J2*(earth.mu./r_norm.^2).*(earth.R./r_norm).^2;
a = a .* [(1 - 5*(r(3)./r_norm).^2).*(r(1)./r_norm), ...
        (1 - 5*(r(3)./r_norm).^2).*(r(2)./r_norm), ...
        (3 - 5*(r(3)./r_norm).^2).*(r(3)./r_norm)];
end

