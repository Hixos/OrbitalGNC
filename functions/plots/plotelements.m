function plotelements(t, el)

tiledlayout(3,2);
N = length(el);

ax1 = nexttile;
for i =1:N
    plot(t./3600, el(i).a);
    hold on
end
title("Semimajor axis");
xlabel("Time [h]");
ylabel("a [km]");
grid on


ax2 = nexttile;
for i =1:N
    plot(t./3600, el(i).e);
    hold on
end
title("Eccentricity");
xlabel("Time [h]");
ylabel("r [-]");
grid on

ax3 = nexttile;
for i =1:N
    plot(t./3600, rad2deg(el(i).i));
    hold on
end
title("Inclination");
xlabel("Time [h]");
ylabel("i [deg]");
grid on

ax4 = nexttile;
for i =1:N
    plot(t./3600, rad2deg(el(i).Om));
    hold on
end
title("RAAN");
xlabel("Time [h]");
ylabel("Om [deg]");
grid on

ax5 = nexttile;
for i =1:N
    plot(t./3600, rad2deg(el(i).om));
    hold on
end
title("Argument of periapsis");
xlabel("Time [h]");
ylabel("om [deg]");
grid on

ax6 = nexttile;
for i =1:N
    plot(t./3600, rad2deg(el(i).th));
    hold on
end
title("True anomaly");
xlabel("Time [h]");
ylabel("theta [deg]");
grid on

linkaxes([ax1, ax2, ax3, ax4, ax5, ax6], "x");

end