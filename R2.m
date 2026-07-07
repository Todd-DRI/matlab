function [r2] =R2(Qs,Qobs)
% r2 - Coefficient of determination
ind = isnan(Qs);
Qs(ind)=[];
Qobs(ind)=[];

ind = isnan(Qobs);
Qs(ind)=[];
Qobs(ind)=[];

Mean_Qs = mean(Qs);
Mean_Qobs = mean(Qobs);
Rnum = sum((Qobs-Mean_Qobs).*(Qs-Mean_Qs));
Rdenom = ((sum((Qobs-Mean_Qobs).^2))^0.5)*((sum((Qs-Mean_Qs).^2))^0.5);
r2 = (Rnum/Rdenom)^2;



