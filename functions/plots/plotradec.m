function [tl] = plotradec(t, alpha, delta, legend_str, tl)
if nargin < 5
tl = tiledlayout(2,1);
ax1 = nexttile;
ax2 = nexttile;
else
ax1 = tl.Children(end);
ax2 = tl.Children(end-1);

hold(ax1, 'on');
hold(ax2, 'on');
end

plot(ax1, t./3600, alpha, 'DisplayName', legend_str);
title(ax1, "Right Ascension");
xlabel(ax1, "Time [h]");
ylabel(ax1, "RA [h]");
grid(ax1, 'on');
legend;

plot(ax2, t./3600, rad2deg(delta), 'DisplayName', legend_str);
title(ax2, "Declination");
xlabel(ax2, "Time [h]");
ylabel(ax2, "Dec [deg]");
grid(ax2, 'on');
legend;
% if ~isempty(R)
%     ax3 = nexttile;
%     plot(t./3600, R, 'DisplayName', legend_str);
%     title("Range");
%     xlabel("Time [h]");
%     ylabel("Range [km]");
%     grid on
% else
%     ax3 = [];
% end
linkaxes([ax1, ax2], "x");

end