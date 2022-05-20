function [tle] = readTLE(str)
lines = split(str, newline);
lines = replace(lines, sprintf('\r'), '');

tle.name = strtrim(lines{1});
tle.catalog = str2double(lines{2}(3:7));

tle.intl_des_year = str2double(lines{2}(10:11));
tle.intl_des_num = str2double(lines{2}(12:14));
tle.intl_des_piece = strtrim(lines{2}(15:17));

tle.epoch_year = str2double(lines{2}(19:20));
tle.epoch_day = str2double(lines{2}(21:32));

tle.n_der_1 = str2double(lines{2}(34:43));
tle.n_der_2 = str2double(lines{2}(45:52));
tle.set_no = str2double(lines{2}(65:68));

tle.i = deg2rad(str2double(lines{3}(9:16)));
tle.Om = deg2rad(str2double(lines{3}(18:25)));
tle.e = str2double("." + lines{3}(27:33));
tle.om = deg2rad(str2double(lines{3}(35:42)));
tle.M = deg2rad(str2double(lines{3}(44:51)));
tle.n = str2double(lines{3}(53:63));
tle.rev_no = str2double(lines{3}(64:68));
end

