function [Q_pi, el0] = perifocalrot(y0, body)
el0 = car2kep(y0, body);

Rz = @(a) [cos(a), sin(a), 0; -sin(a), cos(a), 0; 0,0,1];
Rx = @(a) [1,0,0; 0, cos(a), sin(a); 0, -sin(a), cos(a)];

Q_pi = Rz(el0.om)*Rx(el0.i)*Rz(el0.Om);
end

