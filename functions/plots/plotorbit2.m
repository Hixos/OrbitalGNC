function plotorbit2(y, data, title_str)
if nargin < 3
    title_str = "";
end
[y_p, el0] = eci2perifocal(y, data);
plot(y_p(:,1)./1000, y_p(:,2)./1000);
grid on
xlabel("p [km]");
ylabel("q [km]");
axis equal

title(sprintf("%s (Om=%.2f deg, om=%.2f deg)", title_str, rad2deg(el0.Om), rad2deg(el0.om)));
end

