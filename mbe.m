function [mbe] = mbe(sim,obs)
%MBE - mean bias error for (SIM,OBS) data, V2.0: uses nansum inplace of sum
%V1, T.Caldwell, created 7/27/11
%V
i = length(obs);
k = length(sim);

if i == k;
    mbe =  nansum(sim - obs)/i;
else
    mbe = 999;
end




