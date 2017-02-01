function [ t,vout ] = heuns(f,t0,tf,N,i0,L,R)
    %f is the input voltage as a function of time
    
    func = @(vin,i_in)(vin-R*i_in)/L;
    %func is di/dt as a function of vin and i, at that instant of time
    
    h=((tf-t0)/N); %get the step size
    t=t0:h:tf; %generate an array of each of the times to plot
    
    i_L = ones(size(t)); %generate an array of the currents at each time
    i_L(1) = i0 %set i_L @ t0
    
    vout=zeros(size(t)); %generate an output array of the correct size
    vout(1) = f(t0) - R*i0; %set vout @ t0
    
    for n=1:N % loop for N steps
        
        v = f(t(n)); %get the input voltage at this time instant
        v_step = f(t(n+1)); %get the voltage at the next step
        i_t = i_L(n); %get the previous value of i
        i_pred=i_t + h*func(v,i_t); % predictor for this next value of i
        grad1=func(v,i_t); % gradient at t
        grad2=func(v_step,i_pred); % gradient at t+h
        grad_ave=0.5*(grad1+grad2); % average gradient over [t,t+h]
        i_L(n+1)=i_t+h*grad_ave; % new i from euler, using yave as gradient
        vout(n+1) = v_step - R*i_L(n+1); %get the output voltage

    end
end

