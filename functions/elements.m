function [el] = elements(y, data)
    Nel = size(y,1); 
    
    r = y(:,1:3);
    v = y(:,4:6);
    
    r_norm = vecnorm(y(:,1:3),2,2);
    v_norm = vecnorm(y(:,4:6),2,2);
    
    vr = dot(r,v,2)./r_norm;

    
    h = cross(r, v);
    h_norm = vecnorm(h,2,2);
    
    el.i = acos(h(:,3)./h_norm);
    
    N = cross(repmat([0,0,1],size(h,1),1), h);
    N_norm = vecnorm(N,2,2);
    
    N(N_norm < 1e-6,:) = repmat([1,0,0],size(N(N_norm < 1e-6,:),1),1);
    N_norm(N_norm < 1e-6) = 1;

    el.Om = acos(N(:,1)./N_norm);
    el.Om(N(:,2)  < 0) = 2*pi - el.Om(N(:,2)  < 0);

    
    e = 1/data.mu*((v_norm.^2-data.mu./r_norm).*r-r_norm.*vr.*v);
    
    el.e = vecnorm(e,2,2);
    
    el.om = acos(dot(N,e,2)./(N_norm.*el.e));
    el.om(e(:,3)<0) = 2*pi -  el.om(e(:,3)<0);
    
    el.th = acos(dot(e,r,2)./(el.e.*r_norm));
    el.th(vr < 0) = 2*pi - el.th(vr < 0);
    
    el.rp = h_norm.^2./data.mu.*(1./(1+el.e));
    el.ra = h_norm.^2./data.mu.*(1./(1-el.e));
    
    el.a = (el.rp + el.ra) / 2;
end

