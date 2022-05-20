function JD = julian(y,m,d,UT)
if nargin < 4
    UT = 0;
end

if y < 1901 || y > 2099 || floor(y) ~= y
    error("Year must be an integer between 1901 and 2099");
end
if m < 1 || m > 12  || floor(m) ~= m
    error("Month must be an integer between 1 and 12");
end
if m < 1 || m > 31  || floor(d) ~= d
    error("Day must be an integer between 1 and 31");
end

JD = 367*y - floor(7*(y+floor((m+9)/12))/4) + floor(275*m/9) + d + 1721013.5;
JD = JD + UT/24;
end

