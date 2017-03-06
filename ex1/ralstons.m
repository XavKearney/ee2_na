function [ t,vout ] = ralstons(f,t0,tf,N,i0,L,R)
    %takes as input f, the function describing vin(t)
    
    func = @(vin,i_in)(vin-R*i_in)/L;
    %func is di/dt as a function of vin and i, at that instant of time
    
    h = ((tf-t0)/N); %get the step size
    t = t0:h:tf; %generate an array of each of the times to plot
    
    i_L = ones(size(t)); %generate an array of the currents at each time
    i_L(1) = i0; %set i_L @ t0
    
    vout = zeros(size(t)); %generate an output array of the correct size
    vout(1) = f(t0) - R*i0; %set vout @ t0
    
    for n = 1:N % loop for N steps
        %define temporary variables to limit array accessing
        v = f(t(n)); %get the input voltage at this time instant
        v_step = f(t(n)+2*h/3); %get the voltage at t+(2/3)h
        i_t = i_L(n); %get the previous value of i
        
        k1=h*func(v,i_t); % get k1
        i_pred=i_t + 2*k1/3; % use k1 to predict next i
        
        k2=h*func(v_step,i_pred); % use predictor to get k2
        
        i_L(n+1)=i_t + (k1+3*k2)/4; %combine k1 & k2 to get next i
        
        vout(n+1) = f(t(n+1)) - R*i_L(n+1); %get the output voltage
    end
end

