function [years_n, data_yr] = yrSum(tS_in, data, plot_flag)
% creates annual sum through final day of that month and a matrix 'data' over a period from t_start to t_end
% V1.0, 2/13/20, TGC

%% debugging data obs data
% tS_in = tS_RS_mon';
% data = ET_RS_mon(1,:)';
% clearvars ET3* PPT timest*
% close all

%% create annual time series
[Y_s, ~, ~, ~,~ ] = datevec(tS_in(1));
[Y_e, ~, ~, ~,~ ] = datevec(tS_in(end));

years = Y_s:1:Y_e + 1; %^ add an extra year for aggradation 
years_n = datenum(years,1,1);

clearvars Y_* new_tS i E years

%% data aggradation 
[row, col] = size(data);

data_yr = nan(length(years_n)-1, col);

for i = 2:length(years_n)
    ind = tS_in > years_n(i-1) & tS_in <= years_n(i);
    x = data(ind,:);
    if ~isempty(x)
        data_yr(i-1,:) = nansum(x);
    end
end
years_n(end) = []; %remove last year

% ind = tS_in >= tS_daily(i,1) & tS_in < tS_daily(i,1)+1; % getting the final day
% x = data(ind,:);
% if ~isempty(x)
%     data_24(i,:) = nansum(x);
% end

%% plot check
if plot_flag == 1    
    ind = tS_in <years_n(1) | tS_in >= years_n(end);
    
    tS_in(ind,:) =[];
    data(ind,:) =[];
    
    figure('Position',[100 100 700 600])
    
    for i = 1:col
        subplot(col,1,i)
        
        yyaxis left
        bar(years_n, data_yr(:,i))
        ylabel('Annual total')
        hold on
        yyaxis right
        plot(tS_in, cumsum(data(:,i),'omitnan'),'-k')
        plot(years_n, cumsum(data_yr(:,i),'omitnan'), 'ob','MarkerFaceColor','w')
        ylabel('Cum. sum')
        hold off
        xlim([t_start t_end])
        %ylim([0 0.6])
        datetick('x',12,'KeepLimits')
        grid on
    end
end
