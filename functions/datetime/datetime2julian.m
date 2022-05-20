function jd = datetime2julian(dt)
if nargin == 0
    dt = datetime('now', 'TimeZone','Z');
end
jd = julian(year(dt), month(dt), day(dt), hour(dt) + minute(dt)/60 + second(dt)/3600);
end

