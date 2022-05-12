function plotorbit3(y)

plot3(y(:,1)./1000, y(:,2)./1000, y(:,3)./1000);
axis equal
grid on
xlabel("X [km]");
ylabel("Y [km]");
zlabel("Z [km]");
end

