function [tS_mon, data_mon] = monAve(tS_in, data, t_start,t_end, plot_flag)
% creates monthly mean through final day of that month and a matrix 'data' over a period from t_start to t_end
% V1.0, 2/13/20, TGC, plot flag is for debugging 

%% debugging data obs data
% clearvars
% load('EAA1_final.mat', 'timestamp', 'PPT', 'ET3','ET3_corr')
% 
% tS_in = timestamp;
% data = [PPT ET3_corr./2 ET3./2];
% t_start = datenum('1/1/16');
% t_end = datenum('12/31/18');
% 
% clearvars ET3* PPT timest*
% close all

%% debugging data HYDRUS data
% [TLevel]= ReadTLevelOut;
% tS_in = tS_sim;
% data = flux_sim;
% 
% t_start = datenum('1/1/2016');
% t_end   = datenum('12/31/2018');

%% create monthly time series
clearvars tS_mon %just in case

[Y_s, ~, ~, ~,~ ] = datevec(t_start);
[Y_e, ~, ~, ~,~ ] = datevec(t_end);

years = Y_s:1:Y_e;
years_n = datenum(years,1,1);

i = 1;
E = cumsum(eomday(years(i),1:12));
tS_mon = years_n(i) + E - 1; % last day of each month

for i = 2:length(years)
    E = cumsum(eomday(years(i),1:12));
    new_tS = years_n(i) + E - 1;
    tS_mon = [tS_mon new_tS];
end

clearvars Y_* new_tS i E years

%% data aggradation 
[row, col] = size(data);

data_mon = nan(length(tS_mon), col);

i = 1;
ind = tS_in >= t_start & tS_in <= tS_mon(i); %getting the first month, since tS_mon based on last day of month
x = data(ind,:);
if ~isempty(x)
    data_mon(i,:) = mean(x,'omitnan');
end

for i = 2:length(tS_mon)
    ind = tS_in > tS_mon(i-1) & tS_in <= tS_mon(i);
    x = data(ind,:);
    if ~isempty(x)
        data_mon(i,:) = mean(x,'omitnan');
    end
end

%% plot check
if plot_flag == 1    
    ind = tS_in <tS_mon(1) | tS_in >= tS_mon(end);
    
    tS_in(ind,:) =[];
    data(ind,:) =[];
    
    figure('Position',[100 100 700 600])
    
    for i = 1:col
        subplot(col,1,i)
        
        yyaxis left
        bar(tS_mon, data_mon(:,i))
        ylabel('Mon. mean')
        hold on
        yyaxis right
        plot(tS_in, mean(data(:,i),'omitnan'),'-k')
        plot(tS_mon, mean(data_mon(:,i),'omitnan'), 'ob','MarkerFaceColor','w')
        ylabel('Cum. sum')
        hold off
        xlim([t_start t_end])
        %ylim([0 0.6])
        datetick('x',12,'KeepLimits')
        grid on
    end
end
