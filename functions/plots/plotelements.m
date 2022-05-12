function plotelements(t, el)
tiledlayout(3,2);

ax1 = nexttile;
plot(t./3600, el.a./1000);
title("Semimajor axis");
xlabel("Time [h]");
ylabel("a [km]");
grid on

ax2 = nexttile;
plot(t./3600, el.e);
title("Eccentricity");
xlabel("Time [h]");
ylabel("r [-]");
grid on

ax3 = nexttile;
plot(t./3600, rad2deg(el.i));
title("Inclination");
xlabel("Time [h]");
ylabel("i [deg]");
grid on

ax4 = nexttile;
plot(t./3600, rad2deg(el.Om));
title("RAAN");
xlabel("Time [h]");
ylabel("Om [deg]");
grid on

ax5 = nexttile;
plot(t./3600, rad2deg(el.om));
title("Argument of periapsis");
xlabel("Time [h]");
ylabel("om [deg]");
grid on

ax6 = nexttile;
plot(t./3600, rad2deg(el.th));
title("True anomaly");
xlabel("Time [h]");
ylabel("theta [deg]");
grid on

linkaxes([ax1, ax2, ax3, ax4, ax5, ax6], "x");

end