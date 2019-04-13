b = [4 -1 0 0 0;-1 4 -1 0 0; 0 -1 4 -1 0; 0 0 -1 4 -1;0 0 0 -1 4];
ii = -eye(5);
z = zeros(5);
B = [b ii z z;ii b z z; z z b ii; z z ii b];
f = [z ii ii z];
e = f';
C = b;

schurcomp = C - f*inv(B)*e