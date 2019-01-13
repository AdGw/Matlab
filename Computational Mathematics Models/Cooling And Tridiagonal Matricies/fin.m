% This is a model for the steady state cooling fin.
% Assume heat diffuses in only one direction.
% The resulting algebraic system is solved by trid.m.
%
% Fin Data.
%

n = 40
cond = .001;
csur = .001;
usur = 70.;
uleft = 160.;
T = .1;
W = 10.;
L = 1.;
h = L/n;
CC = csur*2.*(W+T)/(T*W);
for i = 1:n
    x(i) = h*i;
end
%
% Define Tridiagonal Matrix
%
for i = 1:n-1
	a(i) = 2*cond+h*h*CC;
	b(i) = -cond;
	c(i) = -cond;
	d(i) = h*h*CC*usur;
end
d(1) = d(1) + cond*uleft;
a(n) = 2.*cond + h*h*CC + 2.*h*csur;
b(n) = -2.*cond;
d(n) = h*h*CC*usur + 2.*csur*usur*h;
c(n) = 0.0;
%
% Execute Tridiagonal Algorithm

u = trid(n,a,b,c,d)
%
% Output as a Table or Graph
%
u = [uleft u];
x = [0 x];
% [x u];
% Heat entering left side of fin from hot mass
heatenter = T*W*cond*(u(2)-u(1))/h
heatouttip = T*W*csur*(usur-u(n+1));
heatoutlat =h*(2*T+2*W)*csur*(usur-u(1))/2;
for i=2:n
	heatoutlat=heatoutlat+h*(2*T+2*W)*csur*(usur-u(i));
end
heatoutlat=heatoutlat+h*(2*T+2*W)*csur*(usur-u(n+1))/2;
heatout = heatouttip + heatoutlat
errorinheat = heatenter-heatout
plot(x,u)