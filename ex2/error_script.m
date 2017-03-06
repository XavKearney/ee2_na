
R = 0.5; %set resistor and inductor values
L = 1.5e-3;
t0 = 0; %set start and finish times
N = 100; %set number of intervals
i0 = 0; %initial condition of current

T = 130e-6; %set time period
f = @(t) 5*cos(t*2*pi/T); %define input voltage function
tf = T; %set the final time

exact_c = -(5*T^2*R)/(T^2*R^2+4*pi^2*L^2);
exact_i = @(t) (10*pi*T*L*sin(2*pi*t/T)+5*T^2*R*cos(2*pi*t/T))/... %continue to next line
    (T^2*R^2+4*pi^2*L^2)+ exact_c*exp(-R*t/L);

max_ind = 6; %define the maximum index
ind2plot = 2; %define the index to plot for
h_a = zeros(max_ind,1); %initialise array for step sizes
me_h = zeros(max_ind,1); %initialise arrays for max errors
me_m = zeros(max_ind,1);
me_r = zeros(max_ind,1);


figure('Name','Error with Vin = Cosine','NumberTitle','off',...
    'units','normalized','outerposition',[0 0 1 1]); %Set figure title and plot fullscreen
for ind=1:max_ind
    N=10^ind;
    h=((tf-t0)/N);
    
    h_a(ind) = h;
    
    %-----------HEUNS----------
    [t,vout] = heuns(f,t0,tf,N,i0,L,R); %get the output voltage array
    
    vin=arrayfun(f,t); %calculate the input voltages
    
    %above defines the exact solution to the differential equation
    actual_i = arrayfun(exact_i,t); %get the exact current at every t
    actual_vout = vin - R*actual_i; %get the exact Vout at every t
    
    error = actual_vout - vout;
    [maximum,index] = max(abs(error)); %find the maximum error
    
    me_h(ind) = maximum;
    
    if ind == ind2plot
        subplot(3,3,1);
        plot(t,vout,'o'); %plot the calculated vout with method
        hold on;
        plot(t,actual_vout,'--'); %plot the exact vout
        xlabel('Time (s)');
        ylabel('Voltage (V)');
        title('Heuns: Vin = Cosine, A=5, T=130\mus');
        legend('Heuns Vout','Exact Vout');
        hold off;
        subplot(3,3,4);
        plot(t,abs(error),'b*'); %plot the error against time
        hold on;
        plot(t(index),abs(error(index)),'r*'); %change the colour of the max error point
        title('Heuns Error');
        legend('Error','Max Error','Location','southeast');
        hold off;
        xlabel('Time (s)');
        ylabel('Voltage (V)');
    end
    
    
    %------------MIDPOINT-----------
    [t,vout] = midpoint(f,t0,tf,N,i0,L,R); %get the output voltage array
    
    error = actual_vout - vout;
    
    [maximum,index] = max(abs(error)); %find the maximum error
    
    me_m(ind) = maximum;
    
    if ind == ind2plot
        subplot(3,3,2);
        plot(t,vout,'o') %plot the calculated vout with method
        hold on;
        plot(t,actual_vout,'--'); %plot the exact vout
        xlabel('Time (s)');
        ylabel('Voltage (V)');
        title('Midpoint: Vin = Cosine, A=5, T=130\mus')
        legend('Midpoint Vout','Exact Vout')
        hold off;
        subplot(3,3,5);
        plot(t,abs(error),'b*'); %plot the error against time
        hold on;
        plot(t(index),abs(error(index)),'r*'); %change the colour of the max error point
        title('Midpoint Error')
        legend('Error','Max Error','Location','southeast')
        hold off;
        xlabel('Time (s)');
        ylabel('Voltage (V)');
    end
    
    %---------RALSTONS--------
    [t,vout] = ralstons(f,t0,tf,N,i0,L,R); %get the output voltage array
    error = actual_vout - vout;
    
    [maximum,index] = max(abs(error)); %find the maximum error
    me_r(ind) = maximum;
    
    if ind == ind2plot
        subplot(3,3,3);
        plot(t,vout,'o'); %plot the calculated vout with method
        xlabel('Time (s)');
        ylabel('Voltage (V)');
        hold on;
        plot(t,actual_vout,'--'); %plot the exact vout
        title('Ralstons: Vin = Cosine, A=5, T=130\mus')
        legend('Ralstons Vout','Exact Vout')
        hold off;
        subplot(3,3,6);
        plot(t,abs(error),'b*'); %plot the error against time
        hold on;
        plot(t(index),abs(error(index)),'r*'); %change the colour of the max error point
        title('Ralstons Error')
        legend('Error','Max Error','Location','southeast')
        hold off;
        xlabel('Time (s)');
        ylabel('Voltage (V)');
    end
    

end
subplot(3,3,7);
plot(log(h_a),log(me_h),'o');
xlabel('log(h)') % x-axis label
ylabel('log(Max Error)') % y-axis label
grad = polyfit(log(h_a),log(me_h),1); %calculate the gradient of the line
text(-20,-10,['Gradient = ' num2str(grad(1))]);
lsline %plot a least-squares regression line to match the gradient

subplot(3,3,8);
plot(log(h_a),log(me_m),'o');
xlabel('log(h)') % x-axis label
ylabel('log(Max Error)') % y-axis label
grad = polyfit(log(h_a),log(me_m),1); %calculate the gradient of the line
text(-20,-15,['Gradient = ' num2str(grad(1))]);
lsline %plot a least-squares regression line to match the gradient

subplot(3,3,9);
plot(log(h_a),log(me_r),'o');
xlabel('log(h)') % x-axis label
ylabel('log(Max Error)') % y-axis label
grad = polyfit(log(h_a),log(me_r),1); %calculate the gradient of the line
text(-20,-15,['Gradient = ' num2str(grad(1))]);
lsline %plot a least-squares regression line to match the gradient
print(['error'],'-dpng'); %print to file