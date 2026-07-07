function [T_flag] = LI710_diagCodes(diag)
% Import diagnostic interger from LI-710 and decode to binary flags
%   v1.1, 3/11/26, accepts 'nan' as input argument, and returns NaN for row
%   v1.0, 2/25/26, based on read_LI710.m, 4/16/24

% Table 6-1. A diagnostic code is included with each 30-minute measurement.
% A INT value of 0 indicates normal operation. Note bins need reversed to match 
flag_names{16} = 'flow_range'; % Average flow for a 30-minute period is <125 sccm or >330 sccm
flag_names{15} = 'NA1';        % Not applicable
flag_names{14} = 'NA2';        % Not applicable
flag_names{13} = 'lowV_RH';    % Voltage ≤1.6 V for >50% of time for a 30-minute period
flag_names{12} = 'T_range';    % >65 °C or <-50 °C for >5% of time for a 30-minute period
flag_names{11} = 'NA3';        % Not applicable
flag_names{10} = 'no_Sonic';    % Sonic anemometer is not detected
flag_names{9} = 'poor_Sonic';   % Poor sonic signals persist for >10% of time for a 30-minute period
flag_names{8} = 'rain';        % True for >50% of time for a 30-minute period
flag_names{7} = 'high_RH';      % >90% cell RH >2 data points or >90% ambient RH for 100 data points and 50% of the last 100 sonic rain flag data points
flag_names{6} = 'T_cold';      % Cell temperature <0 °C for 100 data points
flag_names{5} = 'cellP_hi';    % Average cell pressure - average ambient pressure is > 0.4 kPa for a 30-minute period
flag_names{4} = 'cellP_low';   % Average cell pressure - average ambient Pressure is < -1.5 kPa for a 30-minute period
flag_names{3} = 'NA4';         % Not applicable 
flag_names{2} = 'lowV_pump';   % Pump voltage <8 V for >50% of time for a 30-minute period
flag_names{1} = 'hiV_pump';    % Pump voltage >20 V for >50% of time for a 30-minute period

%% unpack binary values bit 0-15 
ind = isnan(diag);
diag(ind) = 0;

bin_flags = dec2bin(diag,16); % convert numerical value to 16 binary bins

for i = 1:16
     flags(:,i) = str2num(bin_flags(:,i));
end

T_flag = array2table(flags,"VariableNames", flag_names);
T_flag{ind, :} = NaN;
 
end