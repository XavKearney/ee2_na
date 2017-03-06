function [ t,vout ] = midpoint(f,t0,tf,N,i0,L,R)
    %takes as input f, the function describing vin(t)
    
    func = @(vin,i_in)(vin-R*i_in)/L;
    %func is di/dt as a function of vin and i, at that instant of time
    
    h=((tf-t0)/N); %get the step size
    t = t0:h:tf; %generate an array of each of the times to plot
    
    i_L = ones(size(t)); %generate an array of the currents at each t
    i_L(1) = i0; %set i_L @ t0
    
    vout=zeros(size(t)); %generate an output array of the correct size
    vout(1) = f(t0) - R*i0; %set vout @ t0
    
    for n=1:N % loop for N steps
        %define temporary variables to limit array accessing
        v = f(t(n)); %get the input voltage at this time instant
        v_step = f(t(n)+h/2); %get the voltage at t+h/2
        i_t = i_L(n); %get the previous value of i
        i_pred=i_t + h*func(v,i_t)/2; % predictor for this next value of i
        grad2=func(v_step,i_pred); % gradient at t+h/2
        i_L(n+1)=i_t+h*grad2; % new i from euler, using midpoint gradient
        
        vout(n+1) = f(t(n+1)) - R*i_L(n+1); %get the output voltage

    end
end

