function [tS_daily,data_24, n_rec] = dailySum(tS_in, data, t_start,t_end)
% creates daily sum of matrix 'data' over a period from t_start to t_end
% V1.1, 12/28/21, added number of records to out variables
% V1.0, 2/1/20, TGC

%% debugging data obs data
% clearvars
% load('EAA1_final.mat', 'timestamp', 'PPT', 'ET3','ET3_corr')
% 
% tS_in = timestamp;
% data = [PPT ET3_corr./2 ET3./2];
% t_start = datenum('6/1/16');
% t_end = datenum('12/31/18');
% 
% clearvars ET3* PPT timest*
% close all

%% debugging data HYDRUS data
% [TLevel]= ReadTLevelOut;
% tS_in = tS(:,1);
% data = TLevel(:,2:5);
% 
% t_start = datenum('1/1/2016');
% t_end   = datenum('12/31/2018');

%% data aggradation 
[row, col] = size(data);

tS_daily = (t_start:1:t_end)';
data_24 = nan(length(tS_daily), col);
n_rec = data_24;

for i = 2:length(tS_daily)
    ind = tS_in >= tS_daily(i-1,1) & tS_in < tS_daily(i,1);
    x = data(ind,:);
    if ~isempty(x)
        data_24(i-1,:) = nansum(x);
        n_rec(i-1,:) = sum(ind);
    end
end

ind = isnan(data_24(:,1)); %remove any non-full portions of tS - usually last one or first line. 
data_24(ind,:) = [];
tS_daily(ind,:)= [];
n_rec(ind,:) = [];

%% plot check
% figure('Position',[100 100 700 600])
% ind = tS_in <tS_daily(1,1) | tS_in >= tS_daily(end,1);
% tS_in(ind,:) =[];
% data(ind,:) =[];
% 
% for i = 1:col
%     subplot(col,1,i)
%     plot(tS_in, cumsum(data(:,i),'omitnan'),'-k')
%     hold on
%     plot(tS_daily, cumsum(data_24(:,i),'omitnan'), 'ob')
%     hold off
%     xlim([t_start t_end])
%     %ylim([0 0.6])
%     datetick('x',2,'KeepLimits')
%     grid on
% end
