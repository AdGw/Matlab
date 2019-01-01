%heatgelm.m, solves the 1D steady state heat di?usion
%problem for a number of di?erent values of ?. Note that numerical solutions
%converge to ?(??) where ?(?) is the continuous model and ? is the step size.


n = 3
h = 1./(n+1);
K = .001;
beta = K/(h*h);
A= zeros(n,n);
for i=1:n
	d(i) = sin(pi*i*h)/beta;
	A(i,i) = 2;
	if i<n
        A(i,i+1) = -1;

% HEAT DIFFUSION AND GAUSS ELIMINATION
    end;
if i>1
	A(i,i-1) = -1;
	end;
end
d = d'
A
temp = A\d