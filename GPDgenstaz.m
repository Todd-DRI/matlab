function x = GPDgenstaz(N,zeta0,xi,alpha0) 
% Return an x array with GPD variates of x >= 0 
% From Enrique Vivoni at NMT
% INPUT: 
% N      = number of generated GPD r.v. with zeros (x >= 0)
% zeta0  = Pr[x>0] probability of a 'true' GPD rainy value 
%          NOTE = lambda or 1/inter arrival time (tgc)
% xi     = shape parameter of the GPD = 0 for exponential (tgc)  
% alpha0 = scale parameter of the GPD (reduced to u=0)
%        = **equivalent mean storm depth (tgc)
% OUTPUT:
% x = array of discrete GPD variates mixed to zeros

l_round = 0;

x = zeros(N,1);
p = rand(N,1);
ind = find(p<=zeta0);
x(ind) = GPDrand(length(ind),xi,alpha0,0);

if l_round
	Proundcol = zeros(length(Pround),1); Proundcol(:) = Pround;
   pr = [0; cumsum(Proundcol)*zeta0];
   if abs(pr(end)-zeta0)>eps
      error('GPDgenstaz.m: sum(Pround) differ from 1')
   end
   
   for j= 1:NdX
      ind = find(p>pr(j) & p<=pr(j+1));
	   x(ind) = round(x(ind)/deltax(j))*deltax(j);
   end
end

