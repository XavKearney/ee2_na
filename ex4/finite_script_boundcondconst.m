nx=50;
x0 = 0;
xf = 1;
h = (xf-x0)/nx;

u0 = 0; %set boundary conditions at x0, xf
uf = 0;

nk = 100;
t0 = 0;
tf = 0.02;
k = (tf-t0)/nk;
ta = t0:k:tf; %define t array

v = k/h^2; %define v to generate inverse matrix

xa = x0:h:xf; %define x array for values of x at one time instant

U = zeros(size(xa,2),size(ta,2)); %define matrix U for y at every t and x

%% Define the Initial Conditions (uncomment)
%y0 = @tent; %set y0 as the tent function

y0 = @(x) sin(2*pi*x);

%set initial values of x at t = 0
for j = 1:nx+1
    U(j,1) = y0(xa(j));
end

%% Calculate and Plot
%set boundary condition values for all t at x0,xf
for m = 1:nk+1
    t = ta(m);
    U(1,m) =5;
    U(nx+1,m) = -5;
end

for m = 1:nk-1 %iterate through each time step IS THIS INDEX RIGHT?
    for x = 2:nx %for each x coordinate
        U(x,m+1) = v*U(x-1,m)+(1-2*v)*U(x,m)+v*U(x+1,m); %calc for the next time step
    end
end

figure('name','Finite Differences: Heat Equation')
for m = 1:10:nk+1 %have to skip some otherwise graph too crowded
    plot(xa,U(:,m),'--') %plot each of the time steps on the same axis
    hold on;
end
hold off;
title('Y vs. X for the Heat Equation as t increases')
xlabel('x')
ylabel('y')
