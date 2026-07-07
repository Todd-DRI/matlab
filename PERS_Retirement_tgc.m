%% my estimatation of PERS retirement benefit
%   v1.0, 3/16/25
clearvars; clc

salary = 11122.81;    % Post-emploer reduction monthly salary at return to service
%salary = 158000/12;    % monthly salary at return to service

multiplier = 2.7/100; % my service credit multiplier

prior_years = 11.2;   % prior years of service 

t_start = datetime('01-November-2025');  % my return date
t_now = datetime('now');
t_retire_60 = datetime('01-October-2030'); % my age at 60
t_retire_62 = datetime('01-October-2032'); % my age at 62
t_retire_65 = datetime('01-October-2035'); % my age at 65

display(sprintf('You can retire in %.1f years at 60', (calmonths(between(t_now, t_retire_60, "months"))/12)))
display(sprintf('You can retire in %.1f years at 62', (calmonths(between(t_now, t_retire_62, "months"))/12)))

service_now = calmonths(between(t_start, t_now, "months"));
service_end_60 = calmonths(between(t_start, t_retire_60, "months"));
service_end_62 = calmonths(between(t_start, t_retire_62, "months"));
service_end_65 = calmonths(between(t_start, t_retire_65, "months"));

benefit_now = (service_now/12 + prior_years) * multiplier * salary;
benefit_retire_60 = (service_end_60/12 + prior_years) * multiplier * salary;
benefit_retire_62 = (service_end_62/12 + prior_years) * multiplier * salary;
benefit_retire_65 = (service_end_65/12 + prior_years) * multiplier * salary;

display(sprintf('Your monthly income will be $%.2f at 60',benefit_retire_60))
display(sprintf('Or you can wait until 62 and income will be $%.2f',benefit_retire_62))
display(sprintf('Or you can wait until 65 and income will be $%.2f',benefit_retire_65))
display(sprintf('Or leave today and get $%.2f',benefit_now))