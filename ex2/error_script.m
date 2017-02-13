%TODO: Add Axis labels

R = 0.5; %set resistor and inductor values
L = 1.5e-3;
t0 = 0; %set start and finish times
N = 100; %set number of intervals
i0 = 0; %initial condition of current

T = 130e-6; %set time period
f = @(t) 5*cos(t*2*pi/T); %define input voltage function
tf = T; %set the final time

exact_c = -(5*T^2*R)/(T^2*R^2+4*pi^2*L^2);
exact_i = @(t) (10*pi*T*L*sin(2*pi*t/T))/(T^2*R^2+4*pi^2*L^2)+... %continues onto next line
    (5*T^2*R*cos(2*pi*t/T))/(T^2*R^2+4*pi^2*L^2)+...
    exact_c*exp(-R*t/L);


figure('Name','Error with Vin = Cosine','NumberTitle','off');
for ind=2:5
    N=10^ind;
    h=((tf-t0)/N);
    
    %-----------HEUNS----------
    [t,vout] = heuns(f,t0,tf,N,i0,L,R); %get the output voltage array
    
    vin=arrayfun(f,t); %calculate the input voltages
    
    %above defines the exact solution to the differential equation
    actual_i = arrayfun(exact_i,t); %get the exact current at every t
    actual_vout = vin - R*actual_i; %get the exact Vout at every t
    
    error = actual_vout - vout;
    [maximum,index] = max(abs(error)); %find the maximum error
    
    if ind == 2
        subplot(3,3,1);
        plot(t,vout,'*'); %plot the calculated vout with method
        hold on;
        plot(t,actual_vout,'--'); %plot the exact vout
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
    end
    
    subplot(3,3,7);
    plot(log(h),log(maximum),'*');
    xlabel('log(h)') % x-axis label
    ylabel('log(Max Error)') % y-axis label
    hold on;
    
    %------------MIDPOINT-----------
    [t,vout] = midpoint(f,t0,tf,N,i0,L,R); %get the output voltage array
    
    error = actual_vout - vout;
    
    [maximum,index] = max(abs(error)); %find the maximum error
    
    if ind == 2
        subplot(3,3,2);
        plot(t,vout,'*') %plot the calculated vout with method
        hold on;
        plot(t,actual_vout,'--'); %plot the exact vout
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
    end
    subplot(3,3,8);
    plot(log(h),log(maximum),'*');
    
    xlabel('log(h)') % x-axis label
    ylabel('log(Max Error)') % y-axis label
    hold on;
    
    %---------RALSTONS--------
    [t,vout] = ralstons(f,t0,tf,N,i0,L,R); %get the output voltage array
    error = actual_vout - vout;
    
    [maximum,index] = max(abs(error)); %find the maximum error
    
    if ind == 2
        subplot(3,3,3);
        plot(t,vout,'*'); %plot the calculated vout with method
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
    end
    
    subplot(3,3,9);
    plot(log(h),log(maximum),'*');
    
    xlabel('log(h)') % x-axis label
    ylabel('log(Max Error)') % y-axis label
    hold on;
end