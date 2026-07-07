function [out]=nse(sim, obs)
%NSE - Nash–Sutcliffe model efficiency coefficient, T.Caldwell 3/19/2020
i = length(obs);
k = length(sim);

if i == k
    obs_mean = nanmean(obs);
    numer = (sim - obs).^2;
    denom = (sim - obs_mean).^2;
    out = 1 - nansum(numer)/nansum(denom);
else
    out = 999;
end




