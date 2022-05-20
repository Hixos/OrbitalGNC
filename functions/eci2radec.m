function [alpha,delta,R] = eci2radec(r)
R = vecnorm(r,2,2);
r = r./R;

delta = asin(r(:,3));
alpha = acos(r(:,1)./cos(delta));
alpha(r(:,2) <= 0) = 2*pi - alpha(r(:,2) <= 0);
alpha = alpha / (2*pi)*24;
end

