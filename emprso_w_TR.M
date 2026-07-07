function [Rso,Rs] = emprso_w_TR(lat,P,ea,J, deltaT,tmax_tmin);
%delTMonth = mean monthly difference between climatological Tmax and Tmin ...so 12 values
%J = day of year
%lat = given lat at station (decimal deg)
%ea = actual vapor pressure (in kPa)
%P = pressure at station (in kPa)
%sda = solar declination angle (radians)
Gsc = 4.92; % units MJm^-2h^-1  --- solar constant
 
sinb24=sin(0.85+0.3*(lat.*(pi/180))*sin(((2*pi)/365)*J-1.39)-0.42*(lat.*(pi/180))^2); %epn 24
 

 
W=0.14*ea.*P+2.1; %eqn 22 PRECIPITABLE WATER
Ktb = 0.9;% is the atmospheric clearness coeff. ranges from 0-1. 1 for clean air 

kb=0.98*exp(((-.00146*P)/(Ktb.*sinb24))-0.075*(W./sinb24)^0.4); %eqn 21 index of atmospheric clearness for direct beam radiation

sda = 0.409 *sin(2*pi*J/365-1.39); %eqn 51 -- solar declination angle (radians)

if kb>0.15
    kd=0.35-0.36*kb; %eqn 23 INDEX OF TRANSMISSIVITY FOR DIFFUSE RADIATION
else
    kd=0.18+0.82*kb; %eqn 23 INDEX OF TRANSMISSIVITY FOR DIFFUSE RADIATION
end

kt=kb+kd; %eqn 20 ATMOSPHERIC TRANSMISSIVITY
 
ws=acos(-1*tan((lat.*(pi/180)))*tan(sda));
 
dr=1+0.033*cos((2*pi/365)*J); % eqn 18 -- squared inverse relative distance factor
 
Ra=24/pi*Gsc.*dr.*(ws.*sin(lat.*(pi/180))*sin(sda)+cos(lat.*(pi/180))*cos(sda)*sin(ws)); %eqn 17 EXOATMOSPHERIC RADIATION
 
Rso=kt.*Ra; %eqn 16  theoretical solar radiation
 

% B=0.023+0.1*exp(-0.2*deltaT); %eqn 15  EMPIRICAL FITTING COEFFICIENT %From ALLEN an Robison
B=0.031+0.201*exp(-0.185*deltaT); %eqn 15  EMPIRICAL FITTING COEFFICIENT %TR


Rs=Rso*(1-0.9*exp(-1*B.*(tmax_tmin)^1.5)); %eqn 14 EMPIRICAL SOLAR RADIATION
