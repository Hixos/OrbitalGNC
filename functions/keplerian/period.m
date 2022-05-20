function [T] = period(el, body)

if el.e < 1
    T = 2*pi/sqrt(body.mu)*el.a^(3/2);
else
    T = inf;
end
end

