function perm = topp_inverse(theta_v)
% v1.0, 1/22/26; Invert Topp et al. (1980) equation to get dielectric permittivity 
% from volumetric water content (theta_v).
% Brought to you by Copilot :) 

% Coefficients of the cubic: a*ε^3 + b*ε^2 + c*ε + d = 0
a = 4.3e-6;
b = -5.5e-4;
c = 2.92e-2;
d = -(5.3e-2 + theta_v);

% Solve cubic
r = roots([a b c d]);

% Keep only the real, positive, physically meaningful root
realRoots = r(abs(imag(r)) < 1e-6 & real(r) > 0);
perm = realRoots(1);  % should be only one in the physical range
end



