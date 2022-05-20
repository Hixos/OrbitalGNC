function [el] = car2kep(jd, r, v, body)
    Nel = size(r,1); 

    r_norm = vecnorm(r,2,2);
    v_norm = vecnorm(v,2,2);
    
    vr = dot(r,v,2)./r_norm;

    
    h = cross(r, v);
    h_norm = vecnorm(h,2,2);
    el.epoch = jd;
    el.i = acos(h(:,3)./h_norm);
    
    N = cross(repmat([0,0,1],size(h,1),1), h);
    N_norm = vecnorm(N,2,2);
    
    N(N_norm < 1e-6,:) = repmat([1,0,0],size(N(N_norm < 1e-6,:),1),1);
    N_norm(N_norm < 1e-6) = 1;

    el.Om = acos(N(:,1)./N_norm);
    el.Om(N(:,2)  < 0) = 2*pi - el.Om(N(:,2)  < 0);

    
    e = 1/body.mu*((v_norm.^2-body.mu./r_norm).*r-r_norm.*vr.*v);
    
    el.e = vecnorm(e,2,2);
    
    el.om = acos(dot(N,e,2)./(N_norm.*el.e));
    el.om(e(:,3)<0) = 2*pi -  el.om(e(:,3)<0);
    
    el.th = acos(dot(e,r,2)./(el.e.*r_norm));
    el.th(vr < 0) = 2*pi - el.th(vr < 0);
    
    el.a = zeros(Nel,1);
    el.a(el.e < 1) = h_norm(el.e < 1).^2./body.mu.*(1./(1-el.e(el.e < 1).^2));
    el.a(el.e == 1) = 0.5*h_norm(el.e == 1).^2./body.mu;
    el.a(el.e > 1) = h_norm(el.e > 1).^2./body.mu.*(1./(el.e(el.e > 1).^2-1));
%     el.rp = h_norm.^2./body.mu.*(1./(1+el.e));
%     el.ra = h_norm.^2./body.mu.*(1./(1-el.e));
%     
%     el.a = (el.rp + el.ra) / 2;
end

