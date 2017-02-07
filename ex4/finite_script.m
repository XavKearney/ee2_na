N=1000;
x0 = 0;
xf = 1;
h = (xf-x0)/N;
maxk = 100;

t0 = 0;
tf = 1;
k = (tf-t0)/maxk;


xa = x0:h:xf; %define x array

y = @tent;

%set initial values of x at t = 0
for n = 1:N+1
    x(n) = y(n)
end

for n = 1:N
    xi = x(n);
    u_i = y(xi); %define u_i
    u_in = y(xi+h); %next u_i
    u_ip = y(xi-h); %previous u_i
    d1 = (u_in-u_ip)/(2*h); %define the first derivative
    d2 = (u_in+u_ip-2*u_i)/(h^2);
end