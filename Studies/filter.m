clc
clear all
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    Parametry symulacji
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Lx = 10000;                  % liczba pr�bek symulacji
L = 18;                       % liczba wsp�czynnik�w filtru adaptacyjnego

A = 0;
fx = 1;
fp = 1000;
dt = 1/fp;
t = dt*(0:Lx-1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    Przygotowanie systemu do identyfikacji
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x = A*sin(2*pi*fx*t);   %sygna� zadany
x= awgn(x,1);       % bia�y szum % x(n)

% c - nieznany filtr FIR; Te parametry spr�bujemy znale�� filtrem Wienera
 c = [ -0.0153   -0.0222   -0.0252   -0.0136    0.0175    0.0668    0.1250    0.1771...
      0.2079    0.2079    0.1771    0.1250    0.0668    0.0175   -0.0136   -0.0252...
       -0.0222   -0.0153];

 fvtool(c,1)
 
d = filter(c,1,x);          %operacja filtracji sygna�u % d(n)
plot(x)
hold on
plot(d,'-')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    Rozwiazanie Wienera-Hopfa
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rxx = xcorr(x,x,L-1);      % macierz korelacji w�asnej
R   = toeplitz(rxx(L:-1:1),rxx(L:2*L-1));
                           
rdx = xcorr(d,x,L-1);    
p   = (rdx(L:2*L-1))';   % wektor korelacji wzajemnej

h_opt = inv(R)*p;           % rozwiazanie

fvtool(h_opt,1)

disp('Parametry szukane')
c'
disp('Parametry znalezione przez filtr Wienera')
h_opt
