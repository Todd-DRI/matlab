function [p_out] = cumPPT_WY(t, p_in)
% Create cumulative sums over each water year from WY_start to WY_end
%   based on input time series(tS) and precipitation 

p_out = nan(length(t),1);

[yy, ~, ~, ~,~,~] = datevec(t);
YY = unique(yy);

WY_start = datetime(YY-1,10,1);
WY_end = datetime(YY, 9, 30);

for i = 1:length(YY)
    ind = t >= WY_start(i) & t < WY_end(i);
    p_out(ind,:) = cumsum(p_in(ind,:),'omitnan');
end

end