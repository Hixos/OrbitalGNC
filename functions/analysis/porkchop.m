function [DV, X, Y, V1T] = porkchop(orb_1, orb_2, JD0, DT, N_theta_2, body)
%PORKCHOP Calculated the DV required to perform a transfer in the given
%time range

DV = zeros(length(JD0), length(DT));
V1T = zeros(length(JD0), length(DT), 3);
orb_1 = propagate_elements(orb_1, JD0, body);

orb_2.th = mean2true_anomaly(orb_2.e, linspace(0,2*pi,N_theta_2).');
orb_2.a = repmat(orb_2.a, N_theta_2, 1);
orb_2.e = repmat(orb_2.e, N_theta_2, 1);
orb_2.i = repmat(orb_2.i, N_theta_2, 1);
orb_2.Om = repmat(orb_2.Om, N_theta_2, 1);
orb_2.om = repmat(orb_2.om, N_theta_2, 1);

[r1, v1] = kep2car(orb_1, body);
[r2, v2] = kep2car(orb_2, body);

for i=1:size(r1,1)   
    for j=1:length(DT)
        for k=1:size(r2,2)
            [vt1, vt2] = lambert(r1(i,:), r2(k,:), DT(j), body);   
            dv = norm(v1(i,:)-vt1) + norm(v2(k,:)-vt2);
            if DV(i,j) == 0 || DV(i,j) > dv
                DV(i,j) = dv;
                V1T(i,j,:) = vt1;
            end            
        end     
    end
    
end
X = repmat(JD0', 1, length(DT));
Y = repmat(DT, length(JD0), 1);
end

