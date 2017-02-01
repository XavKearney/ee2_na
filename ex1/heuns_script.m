R = 0.5; %set resistor and inductor values
L = 1.5e-3;
t0 = 0; %set start and finish times
tf = 0.020;
f = @(t) 5; %define the input voltage function
N = 100; %set number of intervals
i0 = 0; %initial condition of current

[t,vout] = heuns(f,t0,tf,N,i0,L,R)
plot(t,vout,'*')