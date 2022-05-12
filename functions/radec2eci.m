function [r] = radec2eci(alpha,delta,R)
r = [cos(delta)*cos(alpha), cos(delta)*sin(alpha), sin(delta)];
r = r*R;
end

