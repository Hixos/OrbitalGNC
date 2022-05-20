function th = mean2true_anomaly(e, M)
N = length(M);
th = zeros(N,1);

if e < 1
    for i=1:N
        f = @(E) E-e*sin(E)-M(i);
        df = @(E) 1 - e*cos(E);
        E = wrapTo2Pi(newton(f, df, M(i), 1e-10));
        th(i) = acos((e-cos(E))./(e*cos(E)-1));
        if E > pi
            th(i) = 2*pi - th(i);
        end
    end
elseif e > 1
    for i=1:N
        f = @(F) e*sinh(F)-F-M(i);
        df = @(F) e*cosh(F)-1;
        F = newton(f, df, 0, 1e-10);
        th(i) = acos((cosh(F)-e)./(1-e*cosh(F)));
    end
else
    th =  2*atan((3*M+sqrt((3*M).^2+1)).^(1/3) - (3*M+sqrt((3*M).^2+1)).^(-1/3));
end
end

