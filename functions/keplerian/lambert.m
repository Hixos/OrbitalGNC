function [v1, v2] = lambert(r1, r2, dt, body)
    rc = cross(r1, r2);
    r1_norm = vecnorm(r1,2,2);
    r2_norm = vecnorm(r2,2,2);
    r1r2 = r1_norm*r2_norm;

    Dth = acos(dot(r1,r2)./(r1r2));
    Dth(rc(3) < 0) = 2*pi - Dth(rc(3) < 0);


    A = sin(Dth)*sqrt(r1r2./(1-cos(Dth)));

    y = @(z) r1_norm + r2_norm + A.*(z.*S(z)-1)./sqrt(C(z));

    F = @(z) (y(z)./C(z)).^(3/2).*S(z) + A.*sqrt(y(z)) - sqrt(body.mu)*dt;
    z = newton(F, @Fdot, 0, 1e-10);
    
    yz = y(z);
    
    f = 1 - yz/r1_norm;
    g = A*sqrt(yz/body.mu);
%     f_dot = sqrt(body.mu)/r1r2 * sqrt(yz/C(z))*( z*S(z) - 1);
    g_dot = 1 - yz/r2_norm;
    
    v1 = 1/g*(r2 - f*r1);
    v2 = 1/g*(g_dot*r2-r1);
    
    
    function fdot = Fdot(z)
        if z == 0
            y0 = y(0);
            y0_s = sqrt(y0);
            fdot = sqrt(2)/40*y0^(3/2) + A/8*( y0_s + A*sqrt( 1/(2*y0) ) );
        else
            fdot = (y(z)/C(z))^(3/2)*( 1/(2*z)*( C(z) - 3/2*S(z)/C(z) ) + ...
                3/4*S(z)^2/C(z) ) + A/8*( 3*S(z)/C(z)*sqrt(y(z)) + A*sqrt( C(z)/y(z) ) );
        end
    end

    function Cz = C(z)
        % Computes the C(z) function (Stumpff function)
        N = length(z);
        Cz = zeros(size(z));

        sz = sqrt(z);
        for i = 1:N
            if z(i) > 0 
                Cz(i) = (1-cos(sz(i)))/z(i);
            elseif z(i) < 0
                Cz(i) = (cosh(sqrt(-z(i)))-1)/(-z(i));
            else
                Cz(i) = 1/2;
            end
        end
    end

    function Sz = S(z)
        % Computes the S(z) function (Stumpff function)
        N = length(z);
        Sz = zeros(size(z));

        z_s = sqrt(z);
        mz_s = sqrt(-z);
        for i = 1:N
            if z(i) > 0 
                Sz(i) = (z_s(i)-sin(z_s(i)))/z_s(i).^3;
            elseif z(i) < 0
                Sz(i) = (sinh(mz_s(i))-mz_s(i))./mz_s(i).^3;
            else
                Sz(i) = 1/6;
            end
        end
    end

end

