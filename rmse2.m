function [rmse]=RMSE(sim,obs)
%RMSE - root mean square error, T.Caldwell 4/25/11
i = length(obs);
k = length(sim);

if i == k
    %rmse =  (nansum((sim - obs).^2)/i)^0.5;
    rmse = sqrt(nanmean((sim - obs).^2));
else
    rmse = 999;
end




