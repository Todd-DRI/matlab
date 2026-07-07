function x = GPDrand(N,xi,alpha,u)
%
% x = GPDrand(N,xi,alpha,u)
%
% Return an array of Generalized Pareto Distribution (GPD)
% random values
%
% INPUT:
% N     = lenght of the returned array with GPD r.v.
% xi    = shape parameter of the GPD distribution
% alpha = scale parameter of the GPD distribution
% u     = threshold parameter of the GPD distribution (zero tgc)
%
% OUTPUT:
% x     = array of random GPD variates

P = rand(N,1);
if abs(xi) > eps% GPD for #>0 (eps = floating point rel. accuracy)
	x = u - alpha/xi*(1-(1-P).^(-xi));
else % exponential
   x = u - alpha*log(1-P);
end   
   
