% Steady state saturated 2D porous flow.
% SOR is used to solve the algebraic system.
% SOR parameters

%In the following MATLAB code por2d.m the SOR method is used to solve the
%discrete model for steady state saturated 2D groundwater porous flow. Lines
%1-44 initialize the data. It is interesting to experiment with eps in line 6, the
%SOR parameter ww in line 7, nx and ny in lines 9,10, the location and flow
%rates of the wells given in lines 12-16, and the size of the flow field given in
%lines 28,29.

clear;
maxm = 500;
eps = .01;
ww = 1.97;
% Porous medium data
nx = 50;
ny = 20;
cond = 10.;
iw = 15;
jw = 12;
iwp = 32;
jwp = 5;
R_well = -250.;
uleft = 100. ;
uright = 100.;
for j=1:ny+1
    u(1,j) = uleft;
    u(nx+1,j) = uright;
end
for j =1:ny+1
    for i = 2:nx
        u(i,j) = 100.;
    end
end
W = 1000.;
L = 5000.;
dx = L/nx;
rdx = 1./dx;
rdx2 = cond/(dx*dx);
dy = W/ny;
rdy = 1./dy;
rdy2 = cond/(dy*dy);
% Calibrate R_well to be independent of the mesh
R_well = R_well/(dx*dy);
xw = (iw)*dx;
yw = (jw)*dy;
for i = 1:nx+1
    x(i) = dx*(i-1);
end
for j = 1:ny+1
    y(j) = dy*(j-1);
end
% Execute SOR Algorithm
nunkno = (nx-1)*(ny+1);
m = 1;
numi = 0;
while ((numi<nunkno)*(m<maxm))
    numi = 0;
% Interior nodes
    for j = 2:ny
        for i=2:nx
            utemp = rdx2*(u(i+1,j)+u(i-1,j));
            utempp = utemp + rdy2*(u(i,j+1)+u(i,j-1));
            utemp = utempp/(2.*rdx2 + 2.*rdy2);
            if ((i==iw)*(j==jw))
                utemp=(utempp+R_well)/(2.*rdx2+2.*rdy2);
        end
        if ((i==iwp)*(j==jwp))
        utemp =(utempp+R_well)/(2.*rdx2+2.*rdy2);
    end
    utemp = (1.-ww)*u(i,j) + ww*utemp;
    error = abs(utemp - u(i,j)) ;
    u(i,j) = utemp;
    if (error<eps)
    numi = numi +1;
    end
    end
end
% Bottom nodes
j = 1;
for i=2:nx
    utemp = rdx2*(u(i+1,j)+u(i-1,j));
    utemp = utemp + 2.*rdy2*(u(i,j+1));
    utemp = utemp/(2.*rdx2 + 2.*rdy2 );
    utemp = (1.-ww)*u(i,j) + ww*utemp;
    error = abs(utemp - u(i,j)) ;
    u(i,j) = utemp;
        if (error<eps)
        numi = numi +1;
        end
end
% Top nodes
j = ny+1;
for i=2:nx
utemp = rdx2*(u(i+1,j)+u(i-1,j));

utemp = utemp + 2.*rdy2*(u(i,j-1));
utemp = utemp/(2.*rdx2 + 2.*rdy2);
utemp = (1.-ww)*u(i,j) + ww*utemp;
error = abs(utemp - u(i,j));
u(i,j) = utemp;
if (error<eps)
numi = numi +1;
end
end
m = m+1;
end
% Output to Terminal
m
ww
meshc(x,y,u')