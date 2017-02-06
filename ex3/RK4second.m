function [ q_next,i_next ] = RK4second(h,L,R,C,qi,iL,ti,vf)
    % q = x
    % iL = q'
    vin = vf(ti);
    fq = @(q,i) i;
    fi = @(q,i) (vin - q/C - R*i)/L;
    
    k1_q = h*fq(qi,iL)
    k1_i = h*fi(qi,iL)
    
    k2_q = h*fq(qi+k1_q/3,iL+k1_i/3)
    k2_i = h*fi(qi+k1_q/3,iL+k1_i/3)
    
    k3_q = h*fq(qi-k1_q/3+k2_q,iL-k1_i/3+k2_i)
    k3_i = h*fi(qi-k1_q/3+k2_q,iL-k1_i/3+k2_i)
    
    k4_q = h*fq(qi+k1_q-k2_q+k3_q,iL+k1_i-k2_i+k3_i)
    k4_i = h*fi(qi+k1_q-k2_q+k3_q,iL+k1_i-k2_i+k3_i)
    
    q_next = qi + (k1_q+3*k2_q+3*k3_q+k4_q)/8
    i_next = iL + (k1_i+3*k2_i+3*k3_i+k4_i)/8


end

