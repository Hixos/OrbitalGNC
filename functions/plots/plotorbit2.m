function plotorbit2(y_eci, Q_pi)

y_p = rotatestatevector(y_eci, Q_pi);
plot(y_p(:,1), y_p(:,2));
hold on
plot(y_p(1,1), y_p(1,2), '>');
plot(y_p(end,1), y_p(end,2), 's');
grid on
xlabel("p [km]");
ylabel("q [km]");
axis equal

% title(sprintf("%s (Om=%.2f deg, om=%.2f deg)", title_str, rad2deg(el0.Om), rad2deg(el0.om)));
end

