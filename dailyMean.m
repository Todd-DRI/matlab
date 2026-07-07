function [tS_daily,data_24] = dailyMean(tS_in, data, t_start,t_end, time_flag)
% creates daily means of matrix 'data' over a period from t_start to t_end
% V1.0, 2/1/20, TGC
% V1.1, 7/13/20, time_flag added: 1, removes any non-filled day (original),
%   0, keeps entire time seriers even if 'nan'

%% debugging data
% clearvars
% load('eaa1_smoisture_v2.mat')
% 
% tS_in = timestamp_all';
% data = sm_all(:,2:7);
% t_start = datenum('1/1/17');
% t_end = datenum('12/31/17');
% 
% clearvars delt* sm_all timest*

%% data aggradation
[row, col] = size(data);

tS_daily = (t_start:1:t_end)';
data_24 = nan(length(tS_daily), col);

for i = 2:length(tS_daily)
    ind = tS_in >= tS_daily(i-1,1) & tS_in < tS_daily(i,1);
    x = data(ind,:);
    data_24(i-1,:) = nanmean(x);
end

if time_flag == 1;
    ind = isnan(data_24(:,1)); %remove any non-full portions of tS - usually last or first line.
    data_24(ind,:) = [];
    tS_daily(ind,:)= [];
end

%% plot check
% figure('Position',[100 100 600 800])
% 
% for i = 1:col
%     subplot(col,1,i)
%     plot(tS_in, data(:,i),'-k')
%     hold on
%     plot(tS_daily, data_24(:,i), 'ob')
%     hold off
%     xlim([t_start t_end])
%     ylim([0 0.6])
%     datetick('x',2,'KeepLimits')
%     grid on
% end

