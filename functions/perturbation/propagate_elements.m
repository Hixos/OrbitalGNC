function [el] = propagate_elements(el, jd, body)
if jd == el.epoch
    return;
end
DT = (jd - el.epoch).*86400;

N = length(DT);

% if strcmp(body.name, 'earth') && el.e < 1
%     J2 = 0.00108263;
%     Om_dot = -(3/2*(sqrt(body.mu)*J2*body.R^2)./((1-el.e.^2).^2*el.a.^(7/2))).*cos(el.i);
%     om_dot = -(3/2*(sqrt(body.mu)*J2*body.R^2)./((1-el.e.^2).^2*el.a.^(7/2))).*(5/2*sin(el.i).^2-2);
%     el.Om = wrapTo2Pi(el.Om + Om_dot*DT);
%     el.om = wrapTo2Pi(el.om + om_dot*DT);
% else
    el.Om = repmat(el.Om, N, 1);
    el.om = repmat(el.om, N, 1);
% end

if el.e < 1
    h2 = body.mu*el.a.*(1-el.e.^2);
elseif el.e == 1
    h2 = 2*el.a*body.mu;
else
    h2 = body.mu*el.a.*(el.e.^2-1);
end
h = sqrt(h2);

if el.e < 1
    n = body.mu^2/h^3*(1-el.e^2)^(3/2);
elseif el.e == 1
    n = mu^2/h^3;
else
    n = body.mu^2/h^3*(el.e^2-1)^(3/2);
end

M0 = true2mean_anomaly(el.e, el.th);
M = M0 + n*DT;
el.th = mean2true_anomaly(el.e, M);

el.a = repmat(el.a, N, 1);
el.e = repmat(el.e, N, 1);
el.i = repmat(el.i, N, 1);
el.epoch = jd;
end

