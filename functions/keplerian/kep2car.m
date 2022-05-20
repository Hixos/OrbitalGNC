function [rout, vout] = kep2car(el, body)
    N = length(el.a);
    
    for i =1:N
        if el.e(i) > 1
            th_inf = acos(-1/el.e(i));
            if abs(wrapToPi(el.th(i))) > th_inf
                el.th(i) = wrapTo2Pi(sign(wrapToPi(el.th(i)))*th_inf*0.99);
                warning("Corrected true anomaly for hyperbolic trajectory (%.0f) to 99%% of th_inf", i);
            end
        end 
    end
      

    h2 = zeros(N, 1);
    for i =1:N
        if el.e(i) < 1
            h2(i) = body.mu*el.a(i).*(1-el.e(i).^2);
        elseif el.e(i) == 1
            h2(i) = 2*el.a(i)*body.mu;
        else
            h2(i) = body.mu*el.a(i).*(el.e(i).^2-1);
        end
    end
    h = sqrt(h2);
    
    r = h2./(body.mu.*(1+el.e.*cos(el.th)));
    
    
    vt = body.mu./h.*(1+el.e.*cos(el.th));
    vr = body.mu./h.*el.e.*sin(el.th);
    
    x_p = [r.*cos(el.th), r.*sin(el.th), zeros(N, 1)];
    v_p = [-vt.*sin(el.th)+vr.*cos(el.th), ...
           vt.*cos(el.th) + vr.*sin(el.th), zeros(N, 1)];
       
    Rz = @(a) [cos(a), sin(a), 0; -sin(a), cos(a), 0; 0,0,1];
    Rx = @(a) [1,0,0; 0, cos(a), sin(a); 0, -sin(a), cos(a)];
    
    y_p = [x_p, v_p];
    rout = zeros(N, 3);
    vout = zeros(N, 3);
    for i=1:N
        Q_ip = Rz(-el.Om(i))*Rx(-el.i(i))*Rz(-el.om(i));
        rout(i,:) = (Q_ip*y_p(i,1:3)')';
        vout(i,:) = (Q_ip*y_p(i,4:6)')';
    end
end

