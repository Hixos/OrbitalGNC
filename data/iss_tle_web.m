function [tle_str] = iss_tle_web()
str = convertCharsToStrings(webread('https://celestrak.com/NORAD/elements/stations.txt'));
lines = splitlines(str);

tle_str = "";
for i = 1:length(lines)
    if contains(lines{i}, 'ZARYA')
        tle_str = lines(i);
        for j=1:2
            tle_str = tle_str + newline + lines(i+j);
        end
    end
end
if strcmp(tle_str, "")
    error("Could not find ZARYA TLE in https://celestrak.com/NORAD/elements/stations.txt");
end
end

