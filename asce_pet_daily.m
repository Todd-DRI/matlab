function [ETr, ETo] = asce_pet_daily(Tmax, Tmin, RHmax, RHmin, u2, Rs_Wm2, z, lat, DOY)
% ASCE_ETR_DAILY, Copilot v1.0, 4/46/26
% Computes daily ASCE standardized alfalfa reference ET (ETr) and grass reference ET (ETo)
%
% Inputs:
%   Tmax    - Daily maximum air temperature [°C]
%   Tmin    - Daily minimum air temperature [°C]
%   RHmax   - Daily maximum relative humidity [%]
%   RHmin   - Daily minimum relative humidity [%]
%   u2      - Mean wind speed at 2 m height [m/s]
%   Rs_Wm2  - Mean solar radiation [W/m^2]
%   z       - Station elevation [m]
%   lat     - Latitude [degrees, positive north]
%   DOY     - Day of year [1–366]
%
% Output:
%   ETr     - Alfalfa reference evapotranspiration [mm/day], A tall, rough, well‑watered crop (~0.5 m height)
%   ETo     - Grass reference evapotranspiration [mm/day], 0.12 m tall, A short, smooth, well‑watered grass (~0.12 m height)
%
% ASCE (2005) Standardized Penman–Monteith

%% Convert solar radiation to MJ/m^2/day
Rs = Rs_Wm2 .* 0.0864;

% Mean temperature
Tmean = (Tmax + Tmin) / 2;

% Saturation vapor pressure
es_Tmax = 0.6108 .* exp((17.27 .* Tmax) ./ (Tmax + 237.3));
es_Tmin = 0.6108 .* exp((17.27 .* Tmin) ./ (Tmin + 237.3));
es = (es_Tmax + es_Tmin) / 2;

% Actual vapor pressure
ea = (es_Tmin .* RHmax/100 + es_Tmax .* RHmin/100) / 2;

% Slope of saturation vapor pressure curve
Delta = (4098 .* es) ./ (Tmean + 237.3).^2;

% Psychrometric constant
P = 101.3 .* ((293 - 0.0065 .* z) ./ 293).^5.26;
gamma = 0.000665 .* P;

% Extraterrestrial radiation
phi = lat * pi/180;
dr = 1 + 0.033 * cos(2*pi/365 * DOY);
delta = 0.409 * sin(2*pi/365 * DOY - 1.39);
ws = acos(-tan(phi) .* tan(delta));

Ra = (24*60/pi) * 0.0820 .* dr .* ...
     (ws .* sin(phi).*sin(delta) + ...
      cos(phi).*cos(delta).*sin(ws));

% Clear-sky radiation
Rso = (0.75 + 2e-5 .* z) .* Ra;

% Estimate net radiation
alpha = 0.23;
Rns = (1 - alpha) .* Rs;

sigma = 4.903e-9;
TmaxK = Tmax + 273.16;
TminK = Tmin + 273.16;

Rnl = sigma .* ((TmaxK.^4 + TminK.^4)/2) .* ...
      (0.34 - 0.14 .* sqrt(ea)) .* ...
      (1.35 .* (Rs ./ Rso) - 0.35);

Rn = Rns - Rnl;

% Soil heat flux
G = 0;

%% ASCE alfalfa daily constants
Cn = 1600;
Cd = 0.38;

% ASCE Penman–Monteith
ETr = (0.408 .* Delta .* (Rn - G) + ...
      gamma .* (Cn ./ (Tmean + 273)) .* u2 .* (es - ea)) ./ ...
      (Delta + gamma .* (1 + Cd .* u2));

%% ASCE grass daily constants
Cn = 900;
Cd = 0.34;

% ASCE Penman–Monteith
ETo = (0.408 .* Delta .* (Rn - G) + ...
      gamma .* (Cn ./ (Tmean + 273)) .* u2 .* (es - ea)) ./ ...
      (Delta + gamma .* (1 + Cd .* u2));
end
