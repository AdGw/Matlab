
% Solves -uxx -uyy = 200+200sin(pi x)sin(pi y)
% Uses u = 0 on the boundary
% Uses steepest descent
% Uses 2D arrays for the column vectors
% Does not explicitly store the matrix
%
n = 20;
h = 1./n;
u(1:n+1,1:n+1)= 0.0;
r(1:n+1,1:n+1)= 0.0;
r(2:n,2:n)= 1000.*h*h;
for j= 2:n
    for i = 2:n
        r(i,j)= h*h*200*(1+sin(pi*(i-1)*h)*sin(pi*(j-1)*h));
	end
end
q(1:n+1,1:n+1)= 0.0;
err = 1.0;
m = 0;
rho = 0.0;

while ((err>.0001)*(m<200))
    m = m+1;
    oldrho = rho;
    rho = sum(sum(r(2:n,2:n).^2)); % dotproduct
    for j= 2:n % sparse matrix product Ar
        for i = 2:n
            q(i,j)=4.*r(i,j)-r(i-1,j)-r(i,j-1)-r(i+1,j)-r(i,j+1);
        end
    end
    alpha = rho/sum(sum(r.*q)); % dotproduct
    u = u + alpha*r;
    r = r - alpha*q;
    err = max(max(abs(r(2:n,2:n)))); % norm(r)
    reserr(m) = err;
end
m
semilogy(reserr)