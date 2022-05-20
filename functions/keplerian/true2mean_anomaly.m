function [M, E] = true2mean_anomaly(e, th)
if e < 1
    E = wrapTo2Pi(atan2((sqrt(1-e.^2).*sin(th)),(e+cos(th))));
    M = wrapTo2Pi(E - e*sin(E));
elseif e > 1
    F = asinh( ( sqrt(e.^2-1).*sin(th) ) ./ (1+e*cos(th)) );
    M = e.*sinh(F) - F;
else
    M = 0.5*tan(th/2) + 1/6*tan(th/2).^3;
end
end

