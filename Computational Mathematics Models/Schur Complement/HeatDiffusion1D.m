b = [2];
e = [0 -1 -1 0];
f = e';
c = [2 -1 0 0; -1 2 0 0;0 0 2 -1; 0 0 -1 2]
a = [b e;f c]

schurcomp = c - f*inv(b)*e

d1 = [1];
d2 = [1 1 1 1]';
dd2 = d2 -f*inv(b)*d1;

x2 = schurcomp\dd2
x1 = inv(b)*(d1-e*x2)
x = a\[d1 d2']'