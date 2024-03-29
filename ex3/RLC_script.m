%% RLC Script - Init
R=230;
C=4.5e-6;
L=500e-3;
q0=500e-9;
i0=0;
 
N=1000;
 
%% Input = 5V Step
name = 'Vin = Step(5V)';
t0 = 0;
tf = 0.04;
h=(tf-t0)/N;
ta = t0:h:tf;
ia = zeros(size(ta));
qa = zeros(size(ta));
vout = zeros(size(ta));
ia(1) = i0;
qa(1) = q0;
 
vf = @(t) 5;
for n=1:N
    [qa(n+1), ia(n+1)] = RK4second(h,L,R,C,qa(n),ia(n),ta(n),vf);
    vout(n) = ia(n)*R;
end
figure('Name',name,'NumberTitle','off'); %create a figure with a descriptive window title
vin=arrayfun(vf,ta); %calculate the input voltages
plot(ta,vin,'--');
hold on;
plot(ta,vout);
title(name) %add a title
hold off;
legend('Vin','Vout'); %add a legend to the plot
xlabel('Time (s)')
ylabel('Voltage (V)')
 
print('plots\Step','-dpng'); %print to file
 
%% Input = 5V Impulse
name = 'Vin = 5V Impulse';
 
t0 = 0;
tf = 0.05;
h=(tf-t0)/N;
ta = t0:h:tf;
 
ia = zeros(size(ta));
qa = zeros(size(ta));
vout = zeros(size(ta));
ia(1) = i0;
qa(1) = q0;
tau = 3e-6;
vf = @(t) 5*exp(-t^2/tau);
for n=1:N
    [qa(n+1), ia(n+1)] = RK4second(h,L,R,C,qa(n),ia(n),ta(n),vf);
    vout(n) = ia(n)*R;
end
figure('Name',name,'NumberTitle','off'); %create a figure with a descriptive window title
vin=arrayfun(vf,ta); %calculate the input voltages
plot(ta,vin,'--');
hold on;
plot(ta,vout);
title(name) %add a title
hold off;
legend('Vin','Vout'); %add a legend to the plot
xlabel('Time (s)')
ylabel('Voltage (V)')
 
print('plots\Impulse','-dpng'); %print to file
 
%% Input = Square Waves of Varying Frequency
figure;
subplot(2,2,1);
t0 = 0;
tf = 0.4;
h=(tf-t0)/N;
ta = t0:h:tf;
% f = 5Hz
name = 'Vin = Square Wave, A=5, f=5Hz';
ia = zeros(size(ta));
qa = zeros(size(ta));
vout = zeros(size(ta));
ia(1) = i0;
qa(1) = q0;
vf = @(t) 5*square(t*2*pi*5);
for n=1:N
    [qa(n+1), ia(n+1)] = RK4second(h,L,R,C,qa(n),ia(n),ta(n),vf);
    vout(n) = ia(n)*R;
end
vin=arrayfun(vf,ta); %calculate the input voltages
plot(ta,vin,'--');
hold on;
plot(ta,vout);
title(name) %add a title
hold off;
legend('Vin','Vout'); %add a legend to the plot
xlabel('Time (s)')
ylabel('Voltage (V)')
 
% f = 95Hz
name = 'Vin = Square Wave, A=5, f=95Hz';
t0 = 0;
tf = 0.05;
h = (tf-t0)/N;
ta = t0:h:tf;
subplot(2,2,2);
ia = zeros(size(ta));
qa = zeros(size(ta));
vout = zeros(size(ta));
ia(1) = i0;
qa(1) = q0;
tau = 3e-3;
vf = @(t) 5*square(t*2*pi*95);
for n=1:N
    [qa(n+1), ia(n+1)] = RK4second(h,L,R,C,qa(n),ia(n),ta(n),vf);
    vout(n) = ia(n)*R;
end
vin=arrayfun(vf,ta); %calculate the input voltages
plot(ta,vin,'--');
hold on;
plot(ta,vout);
title(name) %add a title
hold off;
legend('Vin','Vout'); %add a legend to the plot
xlabel('Time (s)')
ylabel('Voltage (V)')
 
% f = 500Hz
name = 'Vin = Square Wave, A=5, f=500Hz';
t0 = 0;
tf = 0.010;
h = (tf-t0)/N;
ta = t0:h:tf;
subplot(2,2,3);
ia = zeros(size(ta));
qa = zeros(size(ta));
vout = zeros(size(ta));
ia(1) = i0;
qa(1) = q0;
tau = 3e-3;
vf = @(t) 5*square(t*2*pi*500);
for n=1:N
    [qa(n+1), ia(n+1)] = RK4second(h,L,R,C,qa(n),ia(n),ta(n),vf);
    vout(n) = ia(n)*R;
end
vin=arrayfun(vf,ta); %calculate the input voltages
plot(ta,vin,'--');
hold on;
plot(ta,vout);
title(name) %add a title
hold off;
legend('Vin','Vout'); %add a legend to the plot
xlabel('Time (s)')
ylabel('Voltage (V)')
 
print('plots\Square','-dpng'); %print to file
 
%% Input = Sine Waves of Varying Frequency
figure;
subplot(2,2,1);
t0 = 0;
tf = 0.4;
h=(tf-t0)/N;
ta = t0:h:tf;
% f = 5Hz
name = 'Vin = Sine Wave, A=5, f=5Hz';
ia = zeros(size(ta));
qa = zeros(size(ta));
vout = zeros(size(ta));
ia(1) = i0;
qa(1) = q0;
vf = @(t) 5*sin(t*2*pi*5);
for n=1:N
    [qa(n+1), ia(n+1)] = RK4second(h,L,R,C,qa(n),ia(n),ta(n),vf);
    vout(n) = ia(n)*R;
end
vin=arrayfun(vf,ta); %calculate the input voltages
plot(ta,vin,'--');
hold on;
plot(ta,vout);
title(name) %add a title
hold off;
legend('Vin','Vout'); %add a legend to the plot
xlabel('Time (s)')
ylabel('Voltage (V)')
 
% f = 95Hz
name = 'Vin = Sine Wave, A=5, f=95Hz';
t0 = 0;
tf = 0.05;
h = (tf-t0)/N;
ta = t0:h:tf;
subplot(2,2,2);
ia = zeros(size(ta));
qa = zeros(size(ta));
vout = zeros(size(ta));
ia(1) = i0;
qa(1) = q0;
tau = 3e-3;
vf = @(t) 5*sin(t*2*pi*95);
for n=1:N
    [qa(n+1), ia(n+1)] = RK4second(h,L,R,C,qa(n),ia(n),ta(n),vf);
    vout(n) = ia(n)*R;
end
vin=arrayfun(vf,ta); %calculate the input voltages
plot(ta,vin,'--');
hold on;
plot(ta,vout);
title(name) %add a title
hold off;
legend('Vin','Vout'); %add a legend to the plot
xlabel('Time (s)')
ylabel('Voltage (V)')
 
% f = 500Hz
name = 'Vin = Sine Wave, A=5, f=500Hz';
t0 = 0;
tf = 0.015;
h = (tf-t0)/N;
ta = t0:h:tf;
subplot(2,2,3);
ia = zeros(size(ta));
qa = zeros(size(ta));
vout = zeros(size(ta));
ia(1) = i0;
qa(1) = q0;
tau = 3e-3;
vf = @(t) 5*sin(t*2*pi*500);
for n=1:N
    [qa(n+1), ia(n+1)] = RK4second(h,L,R,C,qa(n),ia(n),ta(n),vf);
    vout(n) = ia(n)*R;
end
vin=arrayfun(vf,ta); %calculate the input voltages
plot(ta,vin,'--');
hold on;
plot(ta,vout);
title(name) %add a title
hold off;
legend('Vin','Vout'); %add a legend to the plot
xlabel('Time (s)')
ylabel('Voltage (V)')
 
print('plots\Sin','-dpng'); %print to file