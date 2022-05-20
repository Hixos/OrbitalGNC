function [valid, DV1, DV2, DVT, o_t] = transfer(o_1, o_2, jd1, jd2, body, dt_check)
if nargin < 6
    dt_check = 60;
end

DT = (jd2-jd1)*86400;

kep_1_p = propagate_elements(o_1, jd1, body);
kep_2_p = propagate_elements(o_2, jd2, body);

[r1, v1] = kep2car(kep_1_p, body);
[r2, v2] = kep2car(kep_2_p, body);

[vt1, vt2] = lambert(r1, r2, DT, body);

o_t = car2kep(jd1, r1, vt1, body);

% Check if the transfer goes below the surface of the body
% JD_check = jd1  + ((0:dt_check:DT)./86400).';
% o_t_v = propagate_elements(o_t, JD_check, body);
% r_t_v = kep2car(o_t_v, body);
% r_t_norm = vecnorm(r_t_v,2,2);
% valid = sum(r_t_norm < body.R) == 0;
valid = true;
DV1 = norm(vt1-v1);
DV2 = norm(vt2-v2);
DVT = DV1 + DV2;
end

