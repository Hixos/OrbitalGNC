function [el, tle] = tlefile2kepler(file, earth)
str = fileread(file);
tle = parseTLE(str);
el = tle2kepler(tle, earth);
end

