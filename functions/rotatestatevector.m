function [y_r] = rotatestatevector(y,Q)
y_r = zeros(size(y));
for i=1:size(y, 1)
    y_r(i,1:3) = (Q*y(i,1:3)')';
    if size(y, 2) > 3
        y_r(i,4:6) = (Q*y(i,4:6)')';
    end
end
end

