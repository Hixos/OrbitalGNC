function  el = tle2kepler(tle, earth)
T = 24*60*60/tle.n;
el.a = (T*sqrt(earth.mu)/(2*pi))^(2/3);
el.e = tle.e;
el.i = tle.i;
el.Om = tle.Om;
el.om = tle.om;
el.th = mean2true_anomaly(el.e, tle.M);

if tle.epoch_year >= 57
    y = 1900 + tle.epoch_year;
else
    y = 2000 + tle.epoch_year;
end

el.epoch = julian(y,1,0) + tle.epoch_day;

end

