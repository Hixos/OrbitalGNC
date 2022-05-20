function [y_p, el0, Q_pi] = eci2perifocal(y_eci, data)
[Q_pi, el0] = perifocalrot(y_eci(1,:), data);

y_p = rotatestatevector(y_eci, Q_pi);
end

