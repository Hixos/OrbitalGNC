function [A, P] = apsides(el)
N = length(el);
P = zeros(N,1);
A = zeros(N,1);
for i=1:N
    if el.e(i) < 1
        P(i) = el.a(i).*(1-el.e(i));
        A(i) = 2*el.a(i) - P(i);
    elseif el.e > 1
        P(i) = el.a(i).*(el.e(i))-1;
        A(i) = inf;
    else
        P(i) = el.a(i);
        A(i) = inf;
    end
end

