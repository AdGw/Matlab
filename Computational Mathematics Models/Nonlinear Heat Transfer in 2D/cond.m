% Function for thermal conductivity
function cond = cond(x)
c0 = 1.;
c1 = .10;
c2 = .02;
cond = c0*(1.+ c1*x + c2*x*x);