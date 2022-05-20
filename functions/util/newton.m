function [x, k] = newton(f, df, x0, tol, kmax)
if nargin < 5
    kmax = 50;
end

x = zeros(size(x0));
k = zeros(size(x0));

for i = 1:length(x0)
    k(i) = 1;
    x(i) = x0(i);
    while k(i) < kmax && abs(f(x(i))) > tol
        x(i) = x(i) - f(x(i))./df(x(i));
        k(i) = k(i) + 1;
    end
end
end