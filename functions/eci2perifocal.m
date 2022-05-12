function [y_p, el0] = eci2perifocal(y_eci, data)
[Q_pi, el0] = perifocalrot(y_eci(1,:), data);

y_p = zeros(size(y_eci));
for i=1:size(y_eci, 1)
    y_p(i,1:3) = (Q_pi*y_eci(i,1:3)')';
    y_p(i,4:6) = (Q_pi*y_eci(i,4:6)')';
end
end

