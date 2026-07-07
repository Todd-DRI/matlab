function theta_v = topp_eq(ka)
% v1.0, 1/22/26; calc VWC from  Topp et al. (1980) using dielectric permittivity 

% Coefficients of the cubic: vwc = a*ε^3 + b*ε^2 + c*ε + d
a = 4.3e-6;
b = -5.5e-4;
c = 2.92e-2;
d = -5.3e-2;

% apply Topp equation with coefficients above
theta_v = a.*ka.^3  + b.*ka.^2 + c.*ka + d;

end



