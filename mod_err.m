function [err]=mod_err(sim,obs)
% computes typical SIM vs OBS error values from my existing statistical functions
% (1) R2, (2) rmse, (3) ubrmse, (4) mbe, (5) nse, (6) pearson R, (7) p-value for R, (8) number of obs
% note: -999 = unresolvalbe vector lengths
%       -888 = sim is all NaN;
%       -777 = obs is all NaN;
ind = isnan(sim);
sim(ind) = [];
obs(ind) = [];

if isempty(sim)
    %err = -888.*ones(1,8);
    err = nan(1,8);
    return
end

ind = isnan(obs);
sim(ind) = [];
obs(ind) = [];

if isempty(obs)
    %err = -777.*ones(1,8);
    err = nan(1,8);
    return
end

if length(obs) == length(sim)
    err(1) = R2(sim, obs);
    err(2) = rmse(sim, obs);
    err(3) = rmse(sim - nanmean(sim), obs - nanmean(obs));
    err(4) = mbe(sim, obs);
    err(5) = nse(sim, obs);
    [err(6), err(7)] = corr(sim, obs);
    err(8) = length(obs);
else
    %err = -999.*ones(1,8);
    err = nan(1,8);
end