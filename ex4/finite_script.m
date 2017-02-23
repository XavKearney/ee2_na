nx=50; %define the number of x coordinates to plot
x0 = 0;
xf = 1;
h = (xf-x0)/nx; %calculte the x step size

u0 = 0; %set boundary conditions at x0, xf
uf = 0;

nk = 250; %define the number of time steps
t0 = 0;
tf = 0.05;
k = (tf-t0)/nk; %calc the difference between each time step
ta = t0:k:tf; %define t array

v = k/h^2; %define v to generate inverse matrix (needs to be < 0.5)
if v > 0.5
    warning('v is too large! Try changing nx and nk.');
end

xa = x0:h:xf; %define x array for values of x at one time instant

U = zeros(size(xa,2),size(ta,2)); %define matrix U for y at every t and x

%% Define the Initial Conditions (uncomment, change file name at the bottom)
y0 = @tent;name='Tent'; %set y0 as the tent function
%y0 = @(x) sin(2*pi*x);name='Sine'; %y0 as the sine function
%y0 = @(x) abs(sin(2*pi*x));name='AbsSine'; %absolute value of sine function

%OPTIONAL INITIAL CONDITIONS BELOW
%y0 = @(x) cos(2*pi*x);name='Cos';u0=1;uf=1;
%y0 = @(x) x == 0.5;name='Delta';

%set initial values of x at t = 0
for j = 1:nx+1
    U(j,1) = y0(xa(j));
end

%% Calculate and Plot
%set boundary condition values for all t at x0,xf
for m = 1:nk+1
    U(1,m) = u0;
    U(nx+1,m) = uf;
end

for m = 1:nk %iterate through each time step
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
title(['Heat Equation Solutions for Multiple t, Initial: ' name])
xlabel('x')
ylabel('Temperature')
print(['plots\' name],'-dpng'); %print to file

%Below plots a surface (heatmap) plot for time on the x-axis
figure;
surf(ta,xa,U); %generate surface plot for all t and x
title(['Heat Equation Surface Plot, Initial: ' name]);
colormap jet; %make the colours go from hot to cold
shading interp; %remove the lines between plots
xlabel('t');
ylabel('x');
zlabel('Temperature');
print(['plots\Surface_' name],'-dpng'); %print to file
