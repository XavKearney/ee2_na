%This file includes code to produce all of the plots required
%You can close them all quickly by typing the command "close all"

%% Init - RUN THIS FIRST
R = 0.5; %set resistor and inductor values
L = 1.5e-3;
t0 = 0; %set start and finish times
N = 100; %set number of intervals
i0 = 0; %initial condition of current
method = 'Ralstons'; %define the method (for the figure window titles)

%% INPUT VOLTAGE f = 5 (step function)
name = 'Vin = step(5V)';
tf = 0.020; %set the time period
f = @(t) 5; %define the input voltage as a function of time
[t,vout] = ralstons(f,t0,tf,N,i0,L,R); %get the output voltage array
vin=arrayfun(f,t); %calculate the input voltages
figure('Name',[method ': ' name],'NumberTitle','off'); %create a figure with a descriptive window title and turn off the NumberTitle property
plot(t,vin,'--'); %plot input voltages
hold on; %wait for the second figure
plot(t,vout,'*'); %plot the output voltages
title([method ': ' name]); %add a title
xlabel('Time (s)');
ylabel('Voltage (V)');
hold off;
legend('Vin','Vout'); %add a legend to the plot
print(['plots\' method '\Step'],'-dpng'); %print to file

%% INPUT VOLTAGE f = impulsive signal
name = 'Vin = 4V Impulse';
tf = 0.000035;
f = @(t) 4*exp(-(t^2)/140e-12);
[t,vout] = ralstons(f,t0,tf,N,i0,L,R);
vin=arrayfun(f,t);
figure('Name',[method ': ' name],'NumberTitle','off');
plot(t,vin,'--');
hold on;
plot(t,vout,'*');
title([method ': ' name]); %add a title
xlabel('Time (s)');
ylabel('Voltage (V)');
hold off;
legend('Vin','Vout'); %add a legend to the plot
print(['plots\' method '\Impulse'],'-dpng');

%% INPUT VOLTAGE f = decay signal
name = 'Vin = 4V Exponential Decay';
tf = 0.01;
f = @(t) 4*exp(-(t)/140e-6);
[t,vout] = ralstons(f,t0,tf,N,i0,L,R);
vin=arrayfun(f,t);
figure('Name',[method ': ' name],'NumberTitle','off');
plot(t,vin,'--');
hold on;
plot(t,vout,'*');
title([method ': ' name]); %add a title
xlabel('Time (s)');
ylabel('Voltage (V)');
hold off;
legend('Vin','Vout'); %add a legend to the plot
print(['plots\' method '\Decay'],'-dpng');

%% Sine Wave Inputs of Varying Frequency
%Create a subplot for all the sine wave inputs
figure('Name',[method ': Sine Waves of Varying T'],'NumberTitle','off');
subplot(2,2,1);
%INPUT VOLTAGE f = sine wave @ T=25\mus
name = 'A=5, T=25\mus';
tf = 25e-6;
A=5; %set amplitude
T=25e-6; %set time period
f = @(t) A*sin(t*2*pi/T);
[t,vout] = ralstons(f,t0,tf,N,i0,L,R);
vin=arrayfun(f,t);
plot(t,vin,'--')
hold on;
plot(t,vout);
title([method ': ' name]); %add a title
hold off;
legend('Vin','Vout');
xlabel('Time (s)');
ylabel('Voltage (V)');


subplot(2,2,2);
%INPUT VOLTAGE f = sine wave @ T=140\mus
name = 'A=5, T=140\mus';
tf = 140e-6;
A=5; %set amplitude
T=140e-6; %set time period
f = @(t) A*sin(t*2*pi/T);
[t,vout] = ralstons(f,t0,tf,N,i0,L,R);
vin=arrayfun(f,t);
plot(t,vin,'--');
hold on;
plot(t,vout);
title([method ': ' name]); %add a title
hold off;
legend('Vin','Vout');
xlabel('Time (s)');
ylabel('Voltage (V)');

subplot(2,2,3);
%INPUT VOLTAGE f = sine wave @ T=550\mus
name = 'A=5, T=550\mus';
tf = 550e-6;
A=5; %set amplitude
T=550e-6; %set time period
f = @(t) A*sin(t*2*pi/T);
[t,vout] = ralstons(f,t0,tf,N,i0,L,R);
vin=arrayfun(f,t);
plot(t,vin,'--');
hold on;
plot(t,vout);
title([method ': ' name]); %add a title
hold off;
legend('Vin','Vout');
xlabel('Time (s)');
ylabel('Voltage (V)');

subplot(2,2,4);
%INPUT VOLTAGE f = sine wave @ T=1200\mus
name = 'A=5, T=1200\mus';
tf = 1200e-6;
A=5; %set amplitude
T=1200e-6; %set time period
f = @(t) A*sin(t*2*pi/T);
[t,vout] = ralstons(f,t0,tf,N,i0,L,R);
vin=arrayfun(f,t);
plot(t,vin,'--');
hold on;
plot(t,vout);
title([method ': ' name]); %add a title
hold off;
legend('Vin','Vout');


xlabel('Time (s)');
ylabel('Voltage (V)');
hold off;
legend('Vin','Vout'); %add a legend to the plot
print(['plots\' method '\Sine'],'-dpng');

%% Square Wave Inputs of Varying Frequency
%Create a subplot for all the square wave inputs
figure('Name',[method ': Square Waves of Varying T'],'NumberTitle','off');
subplot(2,2,1);
%INPUT VOLTAGE f = square wave @ T=25\mus
name = 'A=5, T=25\mus';
tf = 25e-6;
A=5; %set amplitude
T=25e-6; %set time period
f = @(t) A*square(t*2*pi/T);
[t,vout] = ralstons(f,t0,tf,N,i0,L,R);
vin=arrayfun(f,t);
plot(t,vin,'--');
hold on;
plot(t,vout);
title([method ': ' name]); %add a title
hold off;
legend('Vin','Vout');
xlabel('Time (s)');
ylabel('Voltage (V)');

subplot(2,2,2);
%INPUT VOLTAGE f = square wave @ T=140\mus
name = 'A=5, T=140\mus';
tf = 140e-6;
A=5; %set amplitude
T=140e-6; %set time period
f = @(t) A*square(t*2*pi/T);
[t,vout] = ralstons(f,t0,tf,N,i0,L,R);
vin=arrayfun(f,t);
plot(t,vin,'--');
hold on;
plot(t,vout);
title([method ': ' name]); %add a title
hold off;
legend('Vin','Vout');
xlabel('Time (s)');
ylabel('Voltage (V)');

subplot(2,2,3);
%INPUT VOLTAGE f = square wave @ T=550\mus
name = 'A=5, T=550\mus';
tf = 550e-6;
A=5; %set amplitude
T=550e-6; %set time period
f = @(t) A*square(t*2*pi/T);
[t,vout] = ralstons(f,t0,tf,N,i0,L,R);
vin=arrayfun(f,t);
plot(t,vin,'--');
hold on;
plot(t,vout);
title([method ': ' name]); %add a title
hold off;
legend('Vin','Vout');
xlabel('Time (s)');
ylabel('Voltage (V)');

subplot(2,2,4);
%INPUT VOLTAGE f = square wave @ T=1200\mus
name = 'A=5, T=1200\mus';
tf = 1200e-6;
A=5; %set amplitude
T=1200e-6; %set time period
f = @(t) A*square(t*2*pi/T);
[t,vout] = ralstons(f,t0,tf,N,i0,L,R);
vin=arrayfun(f,t);
plot(t,vin,'--');
hold on;
plot(t,vout);
title([method ': ' name]); %add a title
hold off;
legend('Vin','Vout');
xlabel('Time (s)');
ylabel('Voltage (V)');

print(['plots\' method '\Square'],'-dpng');

%% Sawtooth Inputs of Varying Frequency
%Create a subplot for all the sawtooth wave inputs
figure('Name',[method ': Sawtooth Waves of Varying T'],'NumberTitle','off');
subplot(2,2,1);
%INPUT VOLTAGE f = sawtooth wave @ T=25\mus
name = 'A=5, T=25\mus';
tf = 2*25e-6;
A=5; %set amplitude
T=25e-6; %set time period
f = @(t) A*sawtooth(t*2*pi/T);
[t,vout] = ralstons(f,t0,tf,N,i0,L,R);
vin=arrayfun(f,t);
plot(t,vin,'--');
hold on;
plot(t,vout);
title([method ': ' name]); %add a title
hold off;
legend('Vin','Vout');
xlabel('Time (s)');
ylabel('Voltage (V)');

subplot(2,2,2);

%INPUT VOLTAGE f = sawtooth wave @ T=140\mus
name = 'A=5, T=140\mus';
tf = 2*140e-6;
A=5; %set amplitude
T=140e-6; %set time period
f = @(t) A*sawtooth(t*2*pi/T);
[t,vout] = ralstons(f,t0,tf,N,i0,L,R);
vin=arrayfun(f,t);
plot(t,vin,'--');
hold on;
plot(t,vout);
title([method ': ' name]); %add a title
hold off;
legend('Vin','Vout');
xlabel('Time (s)');
ylabel('Voltage (V)');

subplot(2,2,3);
%INPUT VOLTAGE f = sawtooth wave @ T=550\mus
name = 'A=5, T=550\mus';
tf = 2*550e-6;
A=5; %set amplitude
T=550e-6; %set time period
f = @(t) A*sawtooth(t*2*pi/T);
[t,vout] = ralstons(f,t0,tf,N,i0,L,R);
vin=arrayfun(f,t);
plot(t,vin,'--');
hold on;
plot(t,vout);
title([method ': ' name]); %add a title
hold off;
legend('Vin','Vout');
xlabel('Time (s)');
ylabel('Voltage (V)');

subplot(2,2,4);
%INPUT VOLTAGE f = sawtooth wave @ T=1200\mus
name = 'A=5, T=1200\mus';
tf = 2*1200e-6;
A=5; %set amplitude
T=1200e-6; %set time period
f = @(t) A*sawtooth(t*2*pi/T);
[t,vout] = ralstons(f,t0,tf,N,i0,L,R);
vin=arrayfun(f,t);
plot(t,vin,'--');
hold on;
plot(t,vout);
title([method ': ' name]); %add a title
hold off;
legend('Vin','Vout');
xlabel('Time (s)');
ylabel('Voltage (V)');
print(['plots\' method '\Sawtooth'],'-dpng');
