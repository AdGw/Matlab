% It is applied to Newton’s law of cooling model.
t(1) = 0; % initial time
y(1) = 200.; % initial temperature
h = 1; % time step
n = 300; % number of time steps of length h
y_obser = 190; % observed temperature at time h_obser
h_obser = 5;
c = ((y_obser - y(1))/h_obser)/(70 - y(1))
a = 1 - c*h
b = c*h*70
% Execute the FOFD Algorithm%
for k = 1:n
    y(k+1) = a*y(k) + b;
    t(k+1) = t(k) + h;
end
plot(t,y)