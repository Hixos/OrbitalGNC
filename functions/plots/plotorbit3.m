function plotorbit3(r, drawplanet)
if nargin < 2
    drawplanet = true;
end
if ~ishold
    dohold = true;
    if drawplanet
        Terra3d();
    end
else
    dohold = false;
end
N = size(r, 1);
R = vecnorm(r(:,1:3), 2,2);
[~, ip] = min(R);
[~, ia] = max(R);

plot3(r(:,1), r(:,2), r(:,3));
axis equal
if dohold
    hold on
end

holdcolor();
plot3(r(1,1), r(1,2), r(1,3), '>');

holdcolor();
plot3(r(end,1), r(end,2),  r(end,3), 's');

holdcolor();
plot3(r(ip,1), r(ip,2), r(ip,3), 'x');

holdcolor();
plot3(r(ia,1), r(ia,2), r(ia,3), 'o');

found = [false, false];
% for i = 2:N
%     if r(i-1,3) < 0 && r(i,3) >= 0 && ~found(1)
%         holdcolor();
%         plot3(r(i,1), r(i,2), r(i,3), '^');           
%         found(1) = true;
%     end
%     if r(i-1,3) > 0 && r(i,3) <= 0 && ~found(2)
%         holdcolor();
%         plot3(r(i,1), r(i,2), r(i,3), 'v');    
%         found(2) = true;
%     end
% end

grid on
xlabel("X [km]");
ylabel("Y [km]");
zlabel("Z [km]");
% incrementcolor();
if dohold
    hold off
end

function holdcolor()
    set(gca, 'ColorOrderIndex', mod(get(gca, 'ColorOrderIndex')-2, ...
        size(get(gca, 'ColorOrder'),1))+1);
end
function incrementcolor()
    set(gca, 'ColorOrderIndex', mod(get(gca, 'ColorOrderIndex')-1, ...
        size(get(gca, 'ColorOrder'),1))+1);
end
end

