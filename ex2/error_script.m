R = 0.5; %set resistor and inductor values
L = 1.5e-3;
t0 = 0; %set start and finish times
N = 100; %set number of intervals
i0 = 0; %initial condition of current

T = 130e-6; %set time period
f = @(t) 5*cos(t*2*pi/T) %define input voltage function

tf = T; %set the final time

%-----------HEUNS----------
[t,vout] = heuns(f,t0,tf,N,i0,L,R) %get the output voltage array

vin=arrayfun(f,t); %calculate the input voltages

exact_i = @(t) 5/(R^2+4*pi^2)*(R*cos(2*pi*t/L)+2*pi*sin(2*pi*t/L))
%above defines the exact solution to the differential equation
actual_i = arrayfun(exact_i,t); %get the exact current at every t
actual_vout = vin - R*actual_i; %get the exact Vout at every t

figure('Name','Error with Vin = Cosine','NumberTitle','off');
subplot(3,2,1)
plot(t,vout,'*') %plot the calculated vout with method
hold on;
plot(t,actual_vout,'--') %plot the exact vout
title('Heuns: Vin = Cosine, A=5, T=130\mus')
legend('Heuns Vout','Exact Vout')
hold off;

subplot(3,2,2)
error = actual_vout - vout
plot(t,abs(error),'b*'); %plot the error against time
hold on;
[maximum,index] = max(abs(error)) %find the maximum error
plot(t(index),abs(error(index)),'r*') %change the colour of the max error point
title('Heuns Error')
legend('Error','Max Error','Location','southeast')
hold off;

%------------MIDPOINT-----------
[t,vout] = midpoint(f,t0,tf,N,i0,L,R) %get the output voltage array
subplot(3,2,3)
plot(t,vout,'*') %plot the calculated vout with method
hold on;
plot(t,actual_vout,'--') %plot the exact vout
title('Midpoint: Vin = Cosine, A=5, T=130\mus')
legend('Midpoint Vout','Exact Vout')
hold off;

subplot(3,2,4)
error = actual_vout - vout
plot(t,abs(error),'b*'); %plot the error against time
hold on;
[maximum,index] = max(abs(error)) %find the maximum error
plot(t(index),abs(error(index)),'r*') %change the colour of the max error point
title('Midpoint Error')
legend('Error','Max Error','Location','southeast')
hold off;

%---------RALSTONS--------
[t,vout] = ralstons(f,t0,tf,N,i0,L,R) %get the output voltage array
subplot(3,2,5)
plot(t,vout,'*') %plot the calculated vout with method
hold on;
plot(t,actual_vout,'--') %plot the exact vout
title('Ralstons: Vin = Cosine, A=5, T=130\mus')
legend('Ralstons Vout','Exact Vout')
hold off;

subplot(3,2,6)
error = actual_vout - vout
plot(t,abs(error),'b*'); %plot the error against time
hold on;
[maximum,index] = max(abs(error)) %find the maximum error
plot(t(index),abs(error(index)),'r*') %change the colour of the max error point
title('Ralstons Error')
legend('Error','Max Error','Location','southeast')
hold off;